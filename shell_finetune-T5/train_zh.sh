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
    --model_name_or_path mt5-large \
    --do_train \
    --do_eval \
    --do_predict \
    --source_lang zh \
    --target_lang zhr \
    --source_prefix "translate Chinese to Chinese: " \
    --train_file $DATA/train.zh.translationese.json \
    --validation_file $DATA/dev.zh.json \
    --test_file $DATA/test.zh.json \
    --output_dir $OUT/model-zh \
    --per_device_train_batch_size 12 \
    --per_device_eval_batch_size 12 \
    --max_tokens_per_batch 1536 \
    --gradient_accumulation_steps 128 \
    --max_source_length 128 \
    --max_target_length 128 \
    --max_steps 1600 \
    --learning_rate 0.0007 \
    --num_beams 5 \
    --adafactor \
    --load_best_model_at_end \
    --save_strategy steps \
    --evaluation_strategy steps \
    --save_steps 200 \
    --eval_steps 200 \
    --overwrite_output_dir \
    --predict_with_generate
 
  
