ROOT=/home/your-path
HUG_CODE=$ROOT/transformers
DATA=$ROOT/data
OUT=$ROOT/out_dir

# ---- generation ----
python $HUG_CODE/examples/pytorch/translation/run_maxtokens_translation.py \
    --model_name_or_path $OUT/model-zh/checkpoint \
    --do_predict \
    --source_lang zh \
    --target_lang zhr \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --max_tokens_per_batch 512 \
    --source_prefix "translate Chinese to Chinese: " \
    --validation_file $DATA/dev.zh.json \ \
    --test_file $DATA/test.zh.json \
    --output_dir $OUT/model-zh/checkpoint/gen \
    --num_beams=5 \
    --overwrite_output_dir \
    --predict_with_generate
    
# ---- M2 scorer ----
python $ROOT/evaluation_scorer/tokenization/en2zh_char.py \
        $OUT/checkpoint/gen/generated_predictions.txt \
        $OUT/checkpoint/gen/char-generated_predictions.txt \    
    

python $HUG_CODE/evaluation_scorer/tokenization/pkunlp/pku_tok.py \
       $OUT/checkpoint/gen/char-generated_predictions.txt \
       $OUT/checkpoint/gen/tok-generated_predictions.txt

python2 $HUG_CODE/evaluation_scorer/m2scorer/scripts/m2scorer.py \
         $OUT/checkpoint/gen/tok-generated_predictions.txt \
        $OUT/evaluation_scorer/m2scorer//test-M2/RULEC-GEC.test.M2 \
        | tee $OUT/checkpoint/gen/result_score.txt

