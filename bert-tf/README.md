## For Training Translationese Classifier
If you want to get the translationese from UN/WMT corpus, you should train translationese classifiers first. You can simply follow the instructions in this section:
### Requirements and Installation
  - [Tensorflow](https://www.tensorflow.org/install) version  >= 1.11.0
  - Python version >= 3.6
  - CUDA & cudatoolkit >= 9.0

   ```
   git clone https://github.com/NLP2CT/Trans4GEC.git
   ```
### Download Data and Models 
  - Download the `UNv1.0.en-zh.tar.gz.00-01` for English/Chinese and `UNv1.0.en-ru.tar.gz.00-02` corpus for Russian from [UNcorpus](https://conferences.unite.un.org/uncorpus/en/downloadoverview), and `WMT16 en-de` corpus for German from [WMT16](https://www.statmt.org/wmt16/translation-task.html). 
   - Download the `data` for training the classifiers from [GoogleDrive](https://drive.google.com/file/d/1cw06k3MChCHD36hFP-93Wd3Q77W7lWrD), where the `train_data-en/zh/de/ru` for Engish/ Chinese/ German/ Russian.
   - Download the pre-training models from [BERT-Base](https://storage.googleapis.com/bert_models/2018_10_18/cased_L-12_H-768_A-12.zip), [Multi-BERT-Base](https://storage.googleapis.com/bert_models/2018_11_23/multi_cased_L-12_H-768_A-12.zip),  [Chinese-BERT-Base](https://storage.googleapis.com/bert_models/2018_11_03/chinese_L-12_H-768_A-12.zip)
   
### Fine-tuning and Evaluation
  - Fine-tuning English, Chinese, German and Russian BERT-based classifiers:
   ```
   sh /shell_train-classifier/ftbert-en.sh
   sh /shell_train-classifier/ftbert-zh.sh
   sh /shell_train-classifier/ftbert-de.sh
   sh /shell_train-classifier/ftbert-ru.sh
   ```
### Identify translationese and native texts.

    ```
    sh /shell_train-classifier/predict-en.sh
    sh /shell_train-classifier/predict-zh.sh
    sh /shell_train-classifier/predict-de.sh
    sh /shell_train-classifier/predict-ru.sh
    ```
    
