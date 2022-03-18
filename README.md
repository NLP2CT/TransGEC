# Understanding and Improving Grammaticial Error Correction with Translationese

The code for Understanding and Improving Grammaticial Error Correction with Translationese. Our models were trained using the NVIDIA Tesla V100 32G and A100 40G GPUs.

## Simplified Instruction
We released the translationese GEC models (`TransGEC`) fine-tuned on (m)T5-large pre-trained language model. If you want to quickly explore our job, the following instructions may be useful to you.

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

The format of the directory of the downloaded data is as follows：

```
data_xx/
 |--train
   |--original
   |--translationese
 |--dev
 |--test
```

## Quik Links

If you want to 
- [Training Translationese Classifiers]()
- []



## Citation


```
Understanding and Improving Grammaticial Error Correction with Translationese

```
