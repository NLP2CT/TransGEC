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


## Reviewer NArZ:
Thank you very much for the careful review.
> **Q1** slightly weak baselines for German and Russian <
Yes, our baselines are slightly weaker than the results by [Rothe et al. (2021)]() based on the T5 xxl model of 11 billion model parameters for German and Russian. Our hardware does not enable us to test our method in such a huge model. However, our method can show consistent improvements for different languages based on the T5 large model, which also can verify its effectiveness.
> **Q2** SOTA works often use larger amounts of synthetic data, it is not clear whether the proposed method still has better performance with them, although I expect it.
Thank you for the reminder. The synthetic data used in previous works is mainly composed of native texts, which have a different style from grammatical error correction (GEC) data. In our work, we confirm that GEC models can benefit from using synthetic data in a similar style (i.e., translationese) for both Transformer models and T5 pre-trained language models (PLM). We will follow your suggestion to test more variants to verify it in future works.
> **Q3** Please refer to https://arxiv.org/pdf/1910.00353 and https://arxiv.org/pdf/2106.03830.pdf for German and Russian SOTA. There methods are not directly comparable with yours, however, the reader should know the works that achieve better scores.
Thank you for the suggestion. These SOTA results will be provided in our final version.

> **Q4** It seems that you are training the model on the concatenation of real and synthetic data. Why not to pretrain on synthetic data on the first stage and then finetine on real data? Please refer to https://arxiv.org/pdf/2005.12592 for the details
Yes. [Omelianchuk et al. (2020)](https://aclanthology.org/2020.bea-1.16.pdf) use a multi-stage training strategy. The first stage is used for pre-training on large synthetic data and the other stages for fine-tuning. In fact, we also implemented a two-stage strategy to finetune T5-large PLM on English GEC data. The results show that the concatenated approach works better ($68.08 F_{0.5}$ vs $67.40 F_{0.5}$ for contact vs two-stage). Our findings are consistent with the results of back-translation work in the field of machine translation, which also trains the models on the concatenation of real and synthetic data [(Sennrich et al., 2016)](https://aclanthology.org/P16-1009.pdf).
References:
Kostiantyn Omelianchuk, Vitaliy Atrasevych, Artem Chernodub, and Oleksandr Skurzhanskyi. 2020. GECToR – Grammatical Error Correction: Tag, Not Rewrite. In Proceedings of the Fifteenth Workshop on Innovative Use of NLP for Building Educational Applications, pages 163–170, Seattle, WA, USA → Online. Association for Computational Linguistics.
Rico Sennrich, Barry Haddow, and Alexandra Birch. 2016. Improving Neural Machine Translation Models with Monolingual Data. In Proceedings of the 54th Annual Meeting of the Association for Computational Linguistics (Volume 1: Long Papers), pages 86–96, Berlin, Germany. Association for Computational Linguistics.
> **Q5** .392 why corruption probabilities have these particular values?
We have conducted several groups of experiments for exploring the best setting of corruption probability. We will add a new comparison table in the new version.
> **Q6** l.393: what do you mean by shuffling positional index?
We mean that we shuffle the words by adding a Gaussian bias to their positions and then reorder the words with a standard deviation of 0.5. We will update it after the discussion.

> **Q7** Figure 6 caption: resembles->resemble
We will correct it in our final version.
