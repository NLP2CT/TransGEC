# Understanding and Improving Grammaticial Error Correction with Translationese

The code for Understanding and Improving Grammaticial Error Correction with Translationese. Our models were trained using the NVIDIA Tesla V100 32G and A100 40G GPUs.

## Simplified Instruction
We released the translationese GEC models fine-tuned on (m)T5-large pre-trained language model. If you want to quickly explore our job, the following instructions may be useful to you.

### Requirements and Installation

This implementation is based on huggingface/[transformers(v4.13.0)](https://github.com/huggingface/transformers)
- [PyTorch](https://pytorch.org/) version >= 1.3.1
- Python version >= 3.6

```
git clone https://github.com/NLP2CT/Trans4GEC.git
cd transformers
pip install .
pip install -r requirements.txt
```

###  Download Translationese (m)T5-GEC Models and Data

Lang. | Model | Description | Model-Download | Data-Download
--- | --- | --- | --- | ---
English | `TransGEC` | Fine-tuned with cLang8-en and translationese | [TransGEC.en.model](xxx) | [data.en](xxx)
German | `TransGEC` | Fine-tuned with cLang8-de and translationese | [TransGEC.de.model](xxx) | [data.de](xxx)
Russain | `TransGEC` | Fine-tuned with cLang8-ru and translationese | [TransGEC.ru.model](xxx) | [data.ru](xxx)
Chinese | `TransGEC` | Fine-tuned with Lang8-zh and translationese | [TransGEC.zh.model](xxx) | [data.zh](xxx)

The directory of the downloaded data：

```
data_xx/
 |--train
   |--original
   |--translationese
 |--dev
 |--test
```





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

## For Training Translationese Classifier
If you want to get the translationese from UN/WMT corpus, you should train translationese classifiers first. You can simply follow the instructions in this section:
- Step 1: Requirements and Installation
  - [Tensorflow](https://www.tensorflow.org/install) version  >= 1.11.0
  - Python version >= 3.6
  - CUDA & cudatoolkit >= 9.0

   ```
   git clone https://github.com/NLP2CT/Trans4GEC.git
   ```
- Step 2: Download Data and Models 
  - Download the `UNv1.0.en-zh.tar.gz.00-01` for English/Chinese and `UNv1.0.en-ru.tar.gz.00-02` corpus for Russian from [UNcorpus](https://conferences.unite.un.org/uncorpus/en/downloadoverview), and `WMT16 en-de` corpus for German from [WMT16](https://www.statmt.org/wmt16/translation-task.html). 
   - Download the `data` for training the classifiers from [GoogleDrive](https://drive.google.com/file/d/1cw06k3MChCHD36hFP-93Wd3Q77W7lWrD/view?usp=sharing), where the `train_data-en/zh/de/ru` for Engish/ Chinese/ German/ Russian.
   - Download the pre-training models from [BERT-Base](https://storage.googleapis.com/bert_models/2018_10_18/cased_L-12_H-768_A-12.zip), [Multi-BERT-Base](https://storage.googleapis.com/bert_models/2018_11_23/multi_cased_L-12_H-768_A-12.zip),  [Chinese-BERT-Base](https://storage.googleapis.com/bert_models/2018_11_03/chinese_L-12_H-768_A-12.zip)
   
- Step 3: Fine-tuning and Evaluation
  - Fine-tuning English, Chinese, German and Russian BERT-based classifiers:
   ```
   sh /shell_train-classifier/ftbert-en.sh
   sh /shell_train-classifier/ftbert-zh.sh
   sh /shell_train-classifier/ftbert-de.sh
   sh /shell_train-classifier/ftbert-ru.sh
   ```
- Step 4: Identify translationese and native texts.

    ```
    sh /shell_train-classifier/predict-en.sh
    sh /shell_train-classifier/predict-zh.sh
    sh /shell_train-classifier/predict-de.sh
    sh /shell_train-classifier/predict-ru.sh
    ```

## Exploiting Translationese for GEC on Transformer Architecture
If you want to use the obtained translationese as input for data augmentation for GEC on `Transformer Architecture`, please follow the instructions below.

### Requirements and Installation

This implementation is based on [fairseq(v0.10.2)](https://github.com/pytorch/fairseq)
- [PyTorch](https://pytorch.org/) version >= 1.2.0
- Python version >= 3.6
- Spacy version >= 3.0.6
```
python -m spacy download en_core_web_sm
python -m spacy download de_core_news_sm
python -m spacy download ru_core_news_sm

cd fairseq
pip install --editable .
```
### Prepare the GEC training data.
- Download `cLang-8` GEC training data for English, German and Russian from [here](https://github.com/google-research-datasets/clang8). Download `BEA2019 Shared Task` from [BEA2019](https://www.cl.cam.ac.uk/research/nl/bea2019st/). Download `NLPCC-2018 Shared Task` for Chinese from [NLPCC2018](https://github.com/zhaoyyoo/NLPCC2018_GEC). The test and dev sets, you can download from [CoNLL2013](https://www.comp.nus.edu.sg/~nlp/conll13st/release2.3.1.tar.gz), [CoNLL2014](https://www.comp.nus.edu.sg/~nlp/conll14st/conll14st-test-data.tar.gz) for English;  [Falko-MERLIN](http://www.sfs.uni-tuebingen.de/~adriane/download/wnut2018/data.tar.gz) for German;  [RULEC-GEC](https://github.com/arozovskaya/RULEC-GEC) for Russian.
- Download Chinese tokenizer from [PKUNLP](https://drive.google.com/file/d/1LmTVBqCNnPlnbvvql5QuLitKGdgZcJnv/view?usp=sharing).



### Generate Synthetic Data
1. Tokenization
  ```
  sh tokenization.sh
  ```
2.  Direct Noise
   ```
   python /fairseq/add-noise.py  -e 1 -s $seed
   ```
### Data Preprocessing
1. The bpe for English, German and Russian using the script `bpe.sh`. Chinese without bpe, because of the character splits.
2. Preprocessing
  ```  
for pat in base native mix trans
do
fairseq-preprocess \
    --source-lang src \
    --target-lang tgt \
    --trainpref $PATH_TO_FOLDER/$pat/train.bpe \
    --validpref $PATH_TO_FOLDER/$pat/dev.bpe \
    --testpref $PATH_TO_FOLDER/$pat/test.bpe \
    --joined-dictionary \
    --destdir $PATH_TO_DATA/bin \
    --workers 10
done
  ```
### Training
```
sh /shell_train-transf/train_en.sh
sh /shell_train-transf/train_de.sh
sh /shell_train-transf/train_ru.sh
sh /shell_train-transf/train_zh.sh
```

### Evaluation
```
fairseq-interactive $PATH_TO_FOLDER/bin \
                 --path $PATH_TO_MODEL \
                 --input $PATH_TO_FOLDER/test.bpe.src" \
                 --buffer-size 1024 \
                 --batch-size 64 \
                 --log-format simple \
                 --beam 5 --lenpen 0.6 \
                 --remove-bpe \
                 | tee > $PATH_TO_OUT
                                  
cat $PATH_TO_OUT | grep -P '^H' | sort -nr -k1.2 | cut -f3- > $PATH_TO_OUT.hyp  
python2 /evaluation_scorer/m2scorer/scripts/m2scorer.py  -v $PATH_TO_OUT.hyp $PATH_TO_M2 | tee $PATH_TO_OUT.score
```
Note: [M2 Scorer](https://github.com/nusnlp/m2scorer) for CoNLL14 English, German, Russian and Chinese. [ERRANT](https://competitions.codalab.org/competitions/20228) for BEA19 English.

   
## Exploiting Translationese for GEC on (m)T5-Large Pre-trained Language Models 
If you want to use the obtained translationese as input for data augmentation for GEC on `(m)T5 large` pre-trained language models, please follow the instructions below.

### Requirements and Installation

This implementation is based on huggingface/[transformers(v4.13.0)](https://github.com/huggingface/transformers)
- [PyTorch](https://pytorch.org/) version >= 1.3.1
- Python version >= 3.6

```
cd transformers
pip install .
pip install -r requirements.txt
```
### Prepare the detokenizer for GEC languages
- Download [Moses Detokenizer](https://raw.githubusercontent.com/moses-smt/mosesdecoder/master/scripts/tokenizer/detokenizer.perl) for English/German/Russian.
```
sh  detokenization.sh
```

### Data Preprocessing
- The train/dev/test sets need to be converted to custom JSONLINES files. Our synthetic data with a `special tag` at the beginning of every source sentence.
```
sh tsv2json.sh
```
### Training
```
sh /shell_finetune-T5/train_en.sh
sh /shell_finetune-T5/train_de.sh
sh /shell_finetune-T5/train_ru.sh
sh /shell_finetune-T5/train_zh.sh
```

### Generation and Evaluation
```
sh /shell_finetune-T5/Generate_evaluate_en.sh
sh /shell_finetune-T5/Generate_evaluate_de.sh
sh /shell_finetune-T5/Generate_evaluate_ru.sh
sh /shell_finetune-T5/Generate_evaluate_zh.sh
```
Note: The tokenizier for BEA2019 English using [spaCy(v1.9.0)](https://spacy.io/).


## Citation


```
Understanding and Improving Grammaticial Error Correction with Translationese

```
