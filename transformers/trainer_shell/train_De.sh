# source your environment
source ~/.bashrc
source activate fairseq-a100

ROOT=/home/your-path
HUG_CODE=$ROOT/transformers
DATA=$ROOT/data
OUT=$ROOT/out_dir

# ---- Train -----
cd $HUG_CODE
CUDA_VISIBLE_DEVICES=0,1,2,3 MKL_THREADING_LAYER=GNU python $HUG_CODE/examples/pytorch/translation/run_maxtokens_translation.py \
    --model_name_or_path google/mt5-large \
    --do_train \
    --do_eval \
    --do_predict \
    --source_lang error \
    --target_lang corret \
    --source_prefix "translate German to German: " \
    --train_file $DATA/train.json \
    --validation_file $DATA/dev.json \
    --test_file $DATA/test14.json \
    --output_dir $OUT/model-en \
    --per_device_train_batch_size 12 \
    --per_device_eval_batch_size 12 \
    --max_tokens_per_batch 1536 \
    --gradient_accumulation_steps 128 \
    --max_source_length 128 \
    --max_target_length 128 \
    --max_steps 600 \
    --learning_rate 0.0007 \
    --num_beams 5 \
    --adafactor \
    --load_best_model_at_end \
    --save_strategy steps \
    --evaluation_strategy steps \
    --save_steps 50 \
    --eval_steps 50 \
    --overwrite_output_dir \
    --predict_with_generate
    
# ---- generation ----
python $HUG_CODE/examples/pytorch/translation/run_maxtokens_translation.py \
    --model_name_or_path $OUT/model-de/checkpoint \
    --do_predict \
    --source_lang error \
    --target_lang correct \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --max_tokens_per_batch 512 \
    --source_prefix "translate German to German: " \
    --validation_file $DATA/dev.json \ \
    --test_file $DATA/test.json \ \
    --output_dir $OUT/model-en/checkpoint/gen \
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


  
    
       
