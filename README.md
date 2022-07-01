# Understanding and Improving Grammaticial Error Correction with Translationese

The code for Understanding and Improving Grammaticial Error Correction with Translationese. Our models were trained using the NVIDIA Tesla V100 32G and A100 40G GPUs.

## Citation


```
Understanding and Improving Grammaticial Error Correction with Translationese,XXX

```


## Simplified Instruction
We released the translationese GEC models (`TransGEC`) fine-tuned on (m)T5-large pre-trained language model. If you want to quickly explore our job, the following instructions may be useful to you.

- Step 1:  Requirements and Installation

    This implementation is based on huggingface/[transformers(v4.13.0)](https://github.com/huggingface/transformers)
    - [PyTorch](https://pytorch.org/) version >= 1.3.1
    - Python version >= 3.6

     ```
   git clone https://github.com/NLP2CT/Trans4GEC.git
   cd transformers
   pip install .
   pip install -r requirements.txt
   ```

- Step 2:  Download Translationese (m)T5-GEC Models and Data

    Lang. | Model | Description | Model-Download | Data-Download
    --- | --- | --- | --- | ---
    En | `TransGEC` | Fine-tuned with cLang8-en and translationese | [TransGEC.en.model](https://drive.google.com/file/d/1_R1PfCAopesq-kewPjbmWf7XHjOxyCBB/view?usp=sharing) | [data.en](https://drive.google.com/file/d/11tTJlKm6Gaj783vEWJLd21H9Ccq_Yw3b/view?usp=sharing)
    De | `TransGEC` | Fine-tuned with cLang8-de and translationese | [TransGEC.de.model](https://drive.google.com/file/d/1jRN2Wa1IxX0L7jtOtaxZvB7fIuw6LEaC/view?usp=sharing) | [data.de](https://drive.google.com/file/d/1zZiiyDWTfIIuCdz1FR4o9xz2XiDv5lDe/view?usp=sharing)
    Ru | `TransGEC` | Fine-tuned with cLang8-ru and translationese | [TransGEC.ru.model](https://drive.google.com/file/d/1FfOeaKm3wviDyQluv9yPjlrVT18ojBC8/view?usp=sharing) | [data.ru](https://drive.google.com/file/d/1uvL9K_7YsoW5GiU5SfhMWDVNqCwzUeyp/view?usp=sharing)
    Zh | `TransGEC` | Fine-tuned with Lang8-zh and translationese | [TransGEC.zh.model](https://drive.google.com/file/d/17PyCWr7AEJ84HhaB3z7qRgui-fQRGHWX/view?usp=sharing) | [data.zh](https://drive.google.com/file/d/1gbrDW5JRlYqqek2C2MM47OAPNfheaWoY/view?usp=sharing)

    The format of the directory of the downloaded data is as follows:
    ```
    data_xx/
     |--train
       |--translationese.tsv
       |--train-translationese.json
     |--dev
       |--dev.xx.json
     |--test
       |--test.xx.json
       |--test.xx.M2
    ```

- Step 3: Generation and Evaluation

    If you want to use the downloaded TransGEC models to generate and evaluate, please refer to the script `transgec_generate.sh` for detailed information.

## Usage
If you want to fine-tune (m)T5-large pre-trained language model from scratch using translationese, please follow the instructions below.

### Fine-tuning
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

## Quick Links

Please refer to the following instructions for more information on our work:

- [Training Translationese Classifiers](https://github.com/NLP2CT/Trans4GEC/tree/main/bert-tf )
- [Training Transformer Models with Translationese](https://github.com/NLP2CT/Trans4GEC/tree/main/fairseq)
- [Fine-tuning (m)T5-Large Models with Translationese](https://github.com/NLP2CT/Trans4GEC/tree/main/transformers)


# Reviewer zX5C:
Thank you very much for the careful review.
## Q1 My strongest concern is using machine translated (MT) data for translationese classification. MT introduces errors by itself, but is has also been shown to exhibit different characteristics to human translated data [1,2].
[1] Bizzoni, Yuri & Juzek, Tom & España-Bonet, Cristina & Chowdhury, Koel & van Genabith, Josef & Teich, Elke. (2020). How Human is Machine Translationese? Comparing Human and Machine Translations of Text and Speech. 280-290. 10.18653/v1/2020.iwslt-1.34.

[2] Fu, Yingxue & Nederhof, Mark-Jan. (2021). Automatic Classification of Human Translation and Machine Translation: A Study from the Perspective of Lexical Diversity.
```
MT indeed introduces errors by itself, but we think that it does not affect the classification accuracy between translationese and native texts: 
(1) The similarities between machine translations and translationese. Some evidence has shown that machine translation is similar to translationese. [Wu et al. (2016)] (https://arxiv.org/pdf/1609.08144.pdf) show that neural machine translation is almost ’human-like’ or that it ’gets closer to that of average human translators’. [Bizzoni et al. (2020)] (https://aclanthology.org/2020.iwslt-1.34.pdf) find that human translation and neural machine translation (RNN/ Transformer) are hardly distinguished. [Rabinovich et al. (2016)] (http://aclanthology.lst.uni-saarland.de/P16-1176.pdf) and [Fu et al. (2021)] (https://aclanthology.org/2021.motra-1.10.pdf) reveal that both machine translation and translationese have lower lexical diversity compared to native texts. To sum up, the above studies show that machine translation and translationese are closer to each other than each of them is to native texts.  The difference between translationese/machine translations and native texts makes our binary classifier can better identify native texts, in other words, it can better identify the translationese.
(2) Some work has already taken the lead. [Riley et al. (2020)](https://aclanthology.org/2020.acl-main.691.pdf) have confirmed that using machine translations and native texts to train a convolutional neural network-based binary classifier can better distinguish translationese from native texts with a promising accuracy ($0.85 F_1$ score) for German. We followed their method to fine-tune BERT for classification task and also evaluate the performance on  the same test set. Our classifier achieves a higher accuracy ($0.91 F_1$ score). It indicates that our  method can better distinguish translationese and native texts.
(3) Guarantees the reliability of the identified text. As shown in Lines 336-338 in our paper, the confidence threshold for identifying translationese (native texts) is set to $>0.9$ ($0.1). The high confidence threshold can ensure that  the classification results are more reliable.
```

