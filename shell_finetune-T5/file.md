## Reviewer NArZ:
Thank you very much for the careful review.

> **Q1** slightly weak baselines for German and Russian

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

## Reviewer zX5C:
Thank you very much for the careful review.
> **Q1** My strongest concern is using machine translated (MT) data for translationese classification. MT introduces errors by itself, but is has also been shown to exhibit different characteristics to human translated data [1,2].
[1] Bizzoni, Yuri & Juzek, Tom & España-Bonet, Cristina & Chowdhury, Koel & van Genabith, Josef & Teich, Elke. (2020). How Human is Machine Translationese? Comparing Human and Machine Translations of Text and Speech. 280-290. 10.18653/v1/2020.iwslt-1.34.
[2] Fu, Yingxue & Nederhof, Mark-Jan. (2021). Automatic Classification of Human Translation and Machine Translation: A Study from the Perspective of Lexical Diversity.


MT indeed introduces errors by itself, but we think that it does not affect the classification accuracy between translationese and native texts: 

(1) The similarities between machine translations and translationese. Some evidence has shown that machine translation is similar to translationese. [Wu et al. (2016)] (https://arxiv.org/pdf/1609.08144.pdf) show that neural machine translation is almost ’human-like’ or that it ’gets closer to that of average human translators’. [Bizzoni et al. (2020)] (https://aclanthology.org/2020.iwslt-1.34.pdf) find that human translation and neural machine translation (RNN/ Transformer) are hardly distinguished. [Rabinovich et al. (2016)] (http://aclanthology.lst.uni-saarland.de/P16-1176.pdf) and [Fu et al. (2021)] (https://aclanthology.org/2021.motra-1.10.pdf) reveal that both machine translation and translationese have lower lexical diversity compared to native texts. To sum up, the above studies show that machine translation and translationese are closer to each other than each of them is to native texts.  The difference between translationese/machine translations and native texts makes our binary classifier can better identify native texts, in other words, it can better identify the translationese.

(2) Some work has already taken the lead. [Riley et al. (2020)](https://aclanthology.org/2020.acl-main.691.pdf) have confirmed that using machine translations and native texts to train a convolutional neural network-based binary classifier can better distinguish translationese from native texts with a promising accuracy ($0.85 F_1$ score) for German. We followed their method to fine-tune BERT for classification task and also evaluate the performance on  the same test set. Our classifier achieves a higher accuracy ($0.91 F_1$ score). It indicates that our  method can better distinguish translationese and native texts.

(3) Guarantees the reliability of the identified text. As shown in Lines 336-338 in our paper, the confidence threshold for identifying translationese (native texts) is set to $>0.9$ ($0.1). The high confidence threshold can ensure that  the classification results are more reliable.

References：

Yonghui Wu, Mike Schuster, Zhifeng Chen, Quoc V. Le, Mohammad Norouzi, Wolfgang Macherey, Maxim Krikun, Yuan Cao, Qin Gao, Klaus Macherey, Jeff Klingner, Apurva Shah, Melvin Johnson, Xiaobing Liu, Lukasz Kaiser, Stephan Gouws, Yoshikiyo Kato, Taku Kudo, Hideto Kazawa, Keith Stevens, George Kurian, Nishant Patil, Wei Wang, Cliff Young, Jason Smith, Jason Riesa, Alex Rudnick, Oriol Vinyals, Greg Corrado, Macduff Hughes, Jeffrey Dean: 2016. Google's Neural Machine Translation System: Bridging the Gap between Human and Machine Translation. CoRR abs/1609.08144 

Bizzoni, Yuri & Juzek, Tom & España-Bonet, Cristina & Chowdhury, Koel & van Genabith, Josef & Teich, Elke. (2020). How Human is Machine Translationese? Comparing Human and Machine Translations of Text and Speech. 280-290. 10.18653/v1/2020.iwslt-1.34.

Ella Rabinovich, Sergiu Nisioi, Noam Ordan, and Shuly Wintner. 2016. On the similarities between native, non-native and translated texts. In Proceedings of the 54th Annual Meeting of the Association for Compu- tational Linguistics (Volume 1: Long Papers), pages 1870–1881, Berlin, Germany. Association for Com- putational Linguistics.

Yingxue Fu and Mark-Jan Nederhof. 2021. Automatic Classification of Human Translation and Machine Translation: A Study from the Perspective of Lexical Diversity. In Proceedings for the First Workshop on Modelling Translation: Translatology in the Digital Age, pages 91–99, online. Association for Computational Linguistics.

Parker Riley, Isaac Caswell, Markus Freitag, and David Grangier. 2020. Translationese as a Language in “Multilingual” NMT. In Proceedings of the 58th Annual Meeting of the Association for Computational Linguistics, pages 7737–7746, Online. Association for Computational Linguistics.


> Q2 I miss statistical tests to see at what level improvements are statistically significant. The authors say the run experiments 3 times for robustness but the dispersion is not shown


To alleviate your doubt, we use the F-test methods to test the significant difference between “+TRANS.” and “+NATIVE” methods on the experimental results with three different random seeds. The result of the significant test is that the $p$-value is smaller than $0.05$ for the four languages. The dispersion of our method and the baselines will be provided after the discussion.



> Q3 The novelty is limited.

Our paper reveals and addresses an important issue in the GEC task. Specifically, most synthetic data is generated from native texts, but the other types of data are not discussed. In our work, we propose a better method for generating synthetic data and alleviating the inconsistency of the GEC data style. It is noted that we are the first to use translationese to improve the performance of GEC.

> Q4 Obtaining translationese. In [3], the authors fine-tuned BERT with small amounts of translationese data and obtained accuracies above 90% for the translationese classification task. Of course, test sets are different, and one cannot compare to your 91%, but since your work makes so much emphasis on translationese, I think your approach should be compared to this.
[3] Pylypenko, Daria & Amponsah-Kaakyire, Kwabena & Chowdhury, Koel & van Genabith, Josef & España-Bonet, Cristina. (2021). Comparing Feature-Engineering and Feature-Learning Approaches for Multilingual Translationese Classification. In Proceedings of the 2021 Conference on Empirical Methods in Natural Language Processing, pages 8596–8611, Online and Punta Cana, Dominican Republic. Association for Computational Linguistics.


Thanks for the suggestion. We will compare our results with the suggested work after the discussion. Our classifier is a monolingual binary classifier. We train four binary classifiers for four languages to distinguish their translationese and native texts.  We test the binary classifiers on the test sets of target languages (English⇒German newstest15/ Chinese⇒English newstest17/ English⇒Chinese newstest17/ English⇒Russian newstest17 for German/ English/ Chinese/ Russian), which consist of native and translationese sentences[(Zhang et al. 2019)](https://aclanthology.org/W19-5208.pdf). Our binary classifiers are different from Pylypenko’s [(Pylypenko et al., 2021)](https://aclanthology.org/2021.emnlp-main.676.pdf), it is consistent with [(Riley et al. 2020)](https://aclanthology.org/2020.acl-main.691.pdf) , which also uses machine translation as a proxy for translationese to train a convolutional neural network-based binary classifier. For a fair comparison, we used the same test set as theirs for testing. Please refer to Lines 341-343 in our paper. 

Mike Zhang and Antonio Toral. 2019. The Effect of Translationese in Machine Translation Test Sets. In Proceedings of the Fourth Conference on Machine Translation (Volume 1: Research Papers), pages 73–81, Florence, Italy. Association for Computational Linguistics.

Pylypenko, Daria & Amponsah-Kaakyire, Kwabena & Chowdhury, Koel & van Genabith, Josef & España-Bonet, Cristina. (2021). Comparing Feature-Engineering and Feature-Learning Approaches for Multilingual Translationese Classification. In Proceedings of the 2021 Conference on Empirical Methods in Natural Language Processing, pages 8596–8611, Online and Punta Cana, Dominican Republic. Association for Computational Linguistics.

Parker Riley, Isaac Caswell, Markus Freitag, and David Grangier. 2020. Translationese as a Language in “Multilingual” NMT. In Proceedings of the 58th Annual Meeting of the Association for Computational Linguistics, pages 7737–7746, Online. Association for Computational Linguistics.

> Q5 Augmentation ratio, Figure 3. I don't fully understand the setup. According to my understanding, the numbers in Figure3-1:1 should correspond to Table3-EN(ConNLL14)-Transformer, but it is not the case. Where is the difference?
Sorry for the confusion. The scores in Table 3 are the average of three experiments with different random seeds, while the scores in Figure 3 are only the results of one seed. We will update the results in Figure 3 by reporting the average scores in our new version. Thank you for the reminder.
> Q6 Data/Preliminary results. From the text, it is not clear to me what is the difference between BEA and the rest. What makes it a preliminary experiment? Is it giving you any information that is used later for the main results?
BEA-2019 training data consists of lang-8, NUCLE, FCE, W&I, which are non-native texts. The previous reviewers suggested that we should also conduct an experiment on this official dataset for demonstrating the effectiveness of our method. Please refer to Section 2.1 of our response. 

 It also provides useful information for later usage. According to the results of table 2, when using test sets in different styles to evaluate the performance, the trend of the results verifies our assumption that using the texts with a similar style for GEC data augmentation is beneficial to GEC tasks. This also provides support for our subsequent experiments in multiple languages.

> Q7 Comparing results (The comparison with the state of the art is not clear (see below))
Only MaskGEC for Chinese is sota according to your description, and you beat the system in this language pair. What is the sota on the other languages? Why the comparison systems are not the sota ones? Your finetuning of mT5 beats all of them, how far are your from the best then?

For the other languages, it is hard to directly compare with the corresponding SOTA systems due to the difference of training data and model source. Rothe et al. (2021) report on the current SOTA systems for English/German/Russian. They fine-tune T5/gT5 xxl models with high-quality human-annotated data. However, the gT5 xxl model is not publicly available and the T5/gT5 xxl models are too large (11 billion parameters) for our hardware to train. We will report the current SOTA results in Table 3 in the new version. 

> Q8 Typos: Figure 1: pronoun and collocation are singular while the other headers are plural; line 326: space before footnote; line 354: Russsian

Thanks for the reminding. We will correct this in the new version. 
 
## Reviewer FEME:
Thank you again for the careful review.

> **Q1** Line 12: "... has better quality than non-native texts". Depends on what you want it for. In your case, non-native texts would be preferable.

Yes, high-quality non-native texts are preferable in our case. But it is hard to collect such data since its quality is hard to be guaranteed. Thus, the alternative high-quality translationese is a good choice in this situation.

> **Q2** Appendix A.3, line 1096: '...collocations (idioms) like "First", and "Unfortunately"...'. "First" and "unfortunately" are not collocations or idioms, they are adverbs.

Thank you for the reminder. We will choose some better examples here. 

> **Q3** Table 2: "+NATIVE can be seen as combining the native texts" What native texts? LOCNESS or other texts you collected? How were they used to train the seq2seq model? Did they have errors corrected or both sided remained the same?

The native texts (i.e.,“+NATIVE”) are identified from the UN corpus (the same source to +TRANS.) using the same BERT classifier.  We use the corrupted texts as source input and unchanged text as target output to train the “+NATIVE” GEC model. We train the seq2seq models with native texts to fairly compare with our “+TRANS.” method.

> **Q4** Table 4: What GEC system is this? The results don't seem to match any of your previous systems. These results are much lower. Can you clarify?

Table 4 shows the analysis results of error types. The GEC systems are based on the Transformer-based  GEC models in Table 2. As shown in Line 414  and Lines 509-511 in our paper, the results in Table 2 are calculated by the M2 scorer, while the results in Table 4 are measured by the ERRANT toolkit. The ERRANT automatically annotates the sentences with many different error types, and the scores calculated by M2 and ERRANT cannot be directly compared. We will clarify this part in the new version.
 
> **Q5** Line 542: "It might be that English and Chinese are the right-branching..." Maybe also that the middle and right parts of the sentence benefit from more previous context?

This can be another better explanation. We will discuss this in the new version.

**Q6-7** (1) Put all URLs within \url{}. (2) TYPOS AND OTHER ERRORS: with -> to (l. 13), ";" -> and (l. 139, 158, 232, 1014, 1035, 1039), translating -> translation (l. 153), on -> in/for (l. 168), recommend only native texts (l. 168), to -> into (l. 182), GEC improvements -> improving GEC (l. 182), been becoming -> become (l. 194), hard (remove, l. 217), from -> on (l. 228), sentences -> sentence (l. 1042), the Stanford POS tagger (l. 1077, also use the same font as the rest of the text), functions -> function (l. 1078), contents -> content (l. 1079), Epoch -> Epochs (Table 5), works -> work (l. 238), which is merged (Figure 2, caption), side -> sides (l. 257), have -> have had (l. 260), convolution -> convolutional (l. 268), "Compared to Riley et al.'s (2020) score of 0.85 F_1..." (l. 342), the UN corpus (l. 1093), it -> them (l. 1098), "," -> and (l. 363, 1100), "*: the data" -> "Data marked with *" (Table 1, caption), to adding (remove, Table 2 caption), While -> However, (l. 1125), indicate using -> use (Table 10, caption), noises -> noise (l. 483), uses an error (l. 492), for the GEC task (l. 494), is fine-tuned (l. 495), the +TRANS. method (l. 497), "we analyze from two perspectives of" -> "we analyze our results from two perspectives:" (l. 503), the ERRANT toolkit (l. 509), for the English (remove, l. 514), "the missing words," -> missing words (l. 516), "," (remove, l. 525 and Table 4 caption), the compare-MT toolkit (l. 1137), train -> training (l. 535), experiment -> experiments (l. 553), the BERT-based (remove, l. 558), "introduce to" (remove, l. 559), a synthetic (l. 559).

Thank you for the careful reading. We will carefully correct the typos and ask a native speaker for proofreading in the new version.

