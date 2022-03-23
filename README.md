# Understanding and Improving Grammaticial Error Correction with Translationese

The code for Understanding and Improving Grammaticial Error Correction with Translationese. Our models were trained using the NVIDIA Tesla V100 32G and A100 40G GPUs.

## Citation


```
Understanding and Improving Grammaticial Error Correction with Translationese,XXX

```


## Simplified Instruction
We released the translationese GEC models (`TransGEC`) fine-tuned on (m)T5-large pre-trained language model. If you want to quickly explore our job, the following instructions may be useful to you.

- Step 1.  Requirements and Installation

This implementation is based on huggingface/[transformers(v4.13.0)](https://github.com/huggingface/transformers)
- [PyTorch](https://pytorch.org/) version >= 1.3.1
- Python version >= 3.6

```
git clone https://github.com/NLP2CT/Trans4GEC.git
cd transformers
pip install .
pip install -r requirements.txt
```

- Step 2.  Download Translationese (m)T5-GEC Models and Data

Lang. | Model | Description | Model-Download | Data-Download
--- | --- | --- | --- | ---
En | `TransGEC` | Fine-tuned with cLang8-en and translationese | [TransGEC.en.model](https://drive.google.com/file/d/1_R1PfCAopesq-kewPjbmWf7XHjOxyCBB/view?usp=sharing) | [data.en](https://drive.google.com/file/d/11tTJlKm6Gaj783vEWJLd21H9Ccq_Yw3b/view?usp=sharing)
De | `TransGEC` | Fine-tuned with cLang8-de and translationese | [TransGEC.de.model](https://drive.google.com/file/d/1jRN2Wa1IxX0L7jtOtaxZvB7fIuw6LEaC/view?usp=sharing) | [data.de](https://drive.google.com/file/d/1zZiiyDWTfIIuCdz1FR4o9xz2XiDv5lDe/view?usp=sharing)
Ru | `TransGEC` | Fine-tuned with cLang8-ru and translationese | [TransGEC.ru.model](https://drive.google.com/file/d/1FfOeaKm3wviDyQluv9yPjlrVT18ojBC8/view?usp=sharing) | [data.ru](https://drive.google.com/file/d/1uvL9K_7YsoW5GiU5SfhMWDVNqCwzUeyp/view?usp=sharing)
Zh | `TransGEC` | Fine-tuned with Lang8-zh and translationese | [TransGEC.zh.model](https://drive.google.com/file/d/17PyCWr7AEJ84HhaB3z7qRgui-fQRGHWX/view?usp=sharing) | [data.zh](https://drive.google.com/file/d/1gbrDW5JRlYqqek2C2MM47OAPNfheaWoY/view?usp=sharing)

The format of the directory of the downloaded data is as follows：

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

- Step 3. Generation and Evaluation
If you want to use the downloaded TransGEC models to generate and evaluate, please refer to the script `transgec_generate.sh` for detailed information.

## Usage



## Quick Links

Please refer to the following instructions for more information on our work:

- [Training Translationese Classifiers](https://github.com/NLP2CT/Trans4GEC/tree/main/bert-tf )
- [Exploiting Translationese for GEC on Transformer Architecture](https://github.com/NLP2CT/Trans4GEC/tree/main/fairseq)
- [Exploiting Translationese for GEC on (m)T5-Large Pre-trained Language Models](https://github.com/NLP2CT/Trans4GEC/tree/main/transformers)



