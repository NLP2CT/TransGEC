# English ##################################################################################### 
# --- for TransGEC.en.model generation and evaluation ---

python $YOUR_PATH/examples/pytorch/translation/run_maxtokens_translation.py \
    --model_name_or_path $YOUR_PATH/TransGEC.en.model \
    --do_predict \
    --source_lang en \
    --target_lang ro \
    --per_device_train_batch_size 8 \
    --per_device_eval_batch_size 8 \
    --max_tokens_per_batch 1024 \
    --source_prefix "translate English to English: " \
    --validation_file $YOUR_PATH/data_en//dev/dev.en.json \ \
    --test_file  $YOUR_PATH/data_en/test/test.en.json \ \
    --output_dir $YOUR_PATH/TransGEC.en.model/gen \
    --num_beams=5 \
    --overwrite_output_dir \
    --predict_with_generate
    
python $YOUR_PATH/script/tokenization/spacy_en.py \
       $YOUR_PATH/TransGEC.en.model/gen/generated_predictions.txt \
       $YOUR_PATH/TransGEC.en.model/gen/tok-generated_predictions.txt
 
# due to the tokenizer is different for CoNLL14
python $YOUR_PATH/script/replace.py \
       $YOUR_PATH/TransGEC.en.model/gen/tok-generated_predictions.txt \
       $YOUR_PATH/TransGEC.en.model/gen/rep-tok-generated_predictions.txt

# ---- M2 scorer for CoNLL2014 ----
python2 $YOUR_PATH/transformers/evaluation_scorer/m2scorer/scripts/m2scorer.py \
        $YOUR_PATH/TransGEC.en.model/gen/rep-tok-generated_predictions.txt \
        $YOUR_PATH/data_en/test/official-2014.combined.m2 \
        | tee  $YOUR_PATH/TransGEC.en.model/gen/result_score.txt
        
# German #####################################################################################        
# --- for TransGEC.de.model generation and evaluation ---

python $YOUR_PATH/examples/pytorch/translation/run_maxtokens_translation.py \
    --model_name_or_path $YOUR_PATH/TransGEC.de.model \
    --do_predict \
    --source_lang de \
    --target_lang der \
    --per_device_train_batch_size 8 \
    --per_device_eval_batch_size 8 \
    --max_tokens_per_batch 1024 \
    --source_prefix "translate German to German: " \
    --validation_file $YOUR_PATH/data_de/dev/dev.de.json \ \
    --test_file  $YOUR_PATH/data_de/test/test.de.json \ \
    --output_dir $YOUR_PATH/TransGEC.de.model/gen \
    --num_beams=5 \
    --overwrite_output_dir \
    --predict_with_generate
    
python $YOUR_PATH/script/tokenization/spacy_de.py \
       $YOUR_PATH/TransGEC.de.model/gen/generated_predictions.txt \
       $YOUR_PATH/TransGEC.de.model/gen/tok-generated_predictions.txt

# ---- M2 scorer for German----
python2 $YOUR_PATH/transformers/evaluation_scorer/m2scorer/scripts/m2scorer.py \
        $YOUR_PATH/TransGEC.de.model/gen/tok-generated_predictions.txt \
        $YOUR_PATH/data_de/test/fm-test-de.m2 \
        | tee  $YOUR_PATH/TransGEC.de.model/gen/result_score.txt

# Russian #####################################################################################        
# --- for TransGEC.ru.model generation and evaluation ---

python $YOUR_PATH/examples/pytorch/translation/run_maxtokens_translation.py \
    --model_name_or_path $YOUR_PATH/TransGEC.ru.model \
    --do_predict \
    --source_lang de \
    --target_lang der \
    --per_device_train_batch_size 8 \
    --per_device_eval_batch_size 8 \
    --max_tokens_per_batch 1024 \
    --source_prefix "translate Russian to Russian: " \
    --validation_file $YOUR_PATH/data_ru/dev/dev.ru.json \ \
    --test_file  $YOUR_PATH/data_ru/test/test.ru.json \ \
    --output_dir $YOUR_PATH/TransGEC.ru.model/gen \
    --num_beams=5 \
    --overwrite_output_dir \
    --predict_with_generate
    
python $YOUR_PATH/script/tokenization/spacy_ru.py \
       $YOUR_PATH/TransGEC.de.model/gen/generated_predictions.txt \
       $YOUR_PATH/TransGEC.de.model/gen/tok-generated_predictions.txt

# ---- M2 scorer for Russian----
python2 $YOUR_PATH/transformers/evaluation_scorer/m2scorer/scripts/m2scorer.py \
        $YOUR_PATH/TransGEC.ru.model/gen/tok-generated_predictions.txt \
        $YOUR_PATH/data_ru/test/RULEC-GEC.test.M2 \
        | tee  $YOUR_PATH/TransGEC.ru.model/gen/result_score.txt
        
# Chinese ##################################################################################### 
# --- for TransGEC.zh.model generation and evaluation ---

python $YOUR_PATH/examples/pytorch/translation/run_maxtokens_translation.py \
    --model_name_or_path $YOUR_PATH/TransGEC.zh.model \
    --do_predict \
    --source_lang en \
    --target_lang ro \
    --per_device_train_batch_size 8 \
    --per_device_eval_batch_size 8 \
    --max_tokens_per_batch 1024 \
    --source_prefix "translate Chinese to Chinese: " \
    --validation_file $YOUR_PATH/data_en//dev/dev.en.json \ \
    --test_file  $YOUR_PATH/data_en/test/test.en.json \ \
    --output_dir $YOUR_PATH/TransGEC.en.model/gen \
    --num_beams=5 \
    --overwrite_output_dir \
    --predict_with_generate
    
# due to the dictionary does not have some Chinese symbols
python $YOUR_PATH/script/chat.py \
       $YOUR_PATH/TransGEC.en.model/gen/tok-generated_predictions.txt \
       $YOUR_PATH/TransGEC.en.model/gen/rep-tok-generated_predictions.txt
      
 python $YOUR_PATH/script/tokenization/spacy_en.py \
       $YOUR_PATH/TransGEC.en.model/gen/generated_predictions.txt \
       $YOUR_PATH/TransGEC.en.model/gen/tok-generated_predictions.txt
 

# ---- M2 scorer for CoNLL2014 ----
python2 $YOUR_PATH/transformers/evaluation_scorer/m2scorer/scripts/m2scorer.py \
        $YOUR_PATH/TransGEC.en.model/gen/rep-tok-generated_predictions.txt \
        $YOUR_PATH/data_en/test/official-2014.combined.m2 \
        | tee  $YOUR_PATH/TransGEC.en.model/gen/result_score.txt       
