ROOT=/home/your-path
HUG_CODE=$ROOT/transformers
DATA=$ROOT/data
OUT=$ROOT/out_dir

# ---- generation ----
python $HUG_CODE/examples/pytorch/translation/run_maxtokens_translation.py \
    --model_name_or_path $OUT/model-en/checkpoint \
    --do_predict \
    --source_lang en \
    --target_lang ro \
    --per_device_train_batch_size 8 \
    --per_device_eval_batch_size 8 \
    --max_tokens_per_batch 1024 \
    --source_prefix "translate English to English: " \
    --validation_file $DATA/dev.en.json \ \
    --test_file $DATA/test.en.json \ \
    --output_dir $OUT/model-en/checkpoint/gen \
    --num_beams=5 \
    --overwrite_output_dir \
    --predict_with_generate
    
# ---- M2 scorer ----
python $HUG_CODE/evaluation_scorer/tokenization/spacy_en.py \
       $OUT/checkpoint/gen/generated_predictions.txt \
       $OUT/checkpoint/gen/tok-generated_predictions.txt
 
# due to the tokenizer for CoNLL14 is different, please replace the ' - ' to '-'
python $HUG_CODE/evaluation_scorer/tokenization/replace.py \
       $OUT/checkpoint/gen/tok-generated_predictions.txt \
       $OUT/checkpoint/gen/rep-tok-generated_predictions.txt


python2 $HUG_CODE/evaluation_scorer/m2scorer/scripts/m2scorer.py \
        $OUT/checkpoint/gen/rep-tok-generated_predictions.txt \
        $OUT/evaluation_scorer/m2scorer/conll14st-test-data/official-2014.combined.m2 \
        | tee $OUT/checkpoint/gen/result_score.txt

    
