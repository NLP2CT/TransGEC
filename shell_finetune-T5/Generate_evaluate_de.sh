ROOT=/home/your-path
HUG_CODE=$ROOT/transformers
DATA=$ROOT/data
OUT=$ROOT/out_dir
  
# ---- generation ----
python $HUG_CODE/examples/pytorch/translation/run_maxtokens_translation.py \
    --model_name_or_path $OUT/model-de/checkpoint \
    --do_predict \
    --source_lang de \
    --target_lang der \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --max_tokens_per_batch 512 \
    --source_prefix "translate German to German: " \
    --validation_file $DATA/dev.de.json \ \
    --test_file $DATA/test.de.json \ \
    --output_dir $OUT/model-de/checkpoint/gen \
    --num_beams=5 \
    --overwrite_output_dir \
    --predict_with_generate
    
# ---- M2 scorer ----
python $HUG_CODE/evaluation_scorer/tokenization/spacy_de.py \
       OUT/checkpoint/gen/generated_predictions.txt \
       OUT/checkpoint/gen/tok-generated_predictions.txt

python2 $HUG_CODE/evaluation_scorer/m2scorer/scripts/m2scorer.py \
        $OUT/checkpoint/gen/tok-generated_predictions.txt \
        $OUT/evaluation_scorer/m2scorer//test-M2/fm-test-de.m2 \
        | tee $OUT/checkpoint/gen/result_score.txt

