# Exploiting Translationese for GEC on Transformer Architecture
If you want to use the obtained translationese as input for data augmentation for GEC on `Transformer Architecture`, please follow the instructions below.

## Requirements and Installation

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
## Prepare the GEC training data.
- Download `cLang-8` GEC training data for English, German and Russian from [here](https://github.com/google-research-datasets/clang8). Download `BEA2019 Shared Task` from [BEA2019](https://www.cl.cam.ac.uk/research/nl/bea2019st/). Download `NLPCC-2018 Shared Task` for Chinese from [NLPCC2018](https://github.com/zhaoyyoo/NLPCC2018_GEC). The test and dev sets, you can download from [CoNLL2013](https://www.comp.nus.edu.sg/~nlp/conll13st/release2.3.1.tar.gz), [CoNLL2014](https://www.comp.nus.edu.sg/~nlp/conll14st/conll14st-test-data.tar.gz) for English;  [Falko-MERLIN](http://www.sfs.uni-tuebingen.de/~adriane/download/wnut2018/data.tar.gz) for German;  [RULEC-GEC](https://github.com/arozovskaya/RULEC-GEC) for Russian.
- Download Chinese tokenizer From [PKUNLP](https://drive.google.com/file/d/1LmTVBqCNnPlnbvvql5QuLitKGdgZcJnv/view?usp=sharing).



## Generate Synthetic Data
1. Tokenization
  ```
  sh tokenization.sh
  ```
2.  Direct Noise
   ```
   python /fairseq/add-noise.py  -e 1 -s $seed
   ```
## Data Preprocessing
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
