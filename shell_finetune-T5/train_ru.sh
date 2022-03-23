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
    --model_name_or_path t5-large \
    --do_train \
    --do_eval \
    --do_predict \
    --source_lang ru \
    --target_lang rur \
    --source_prefix "translate Russian to Russian: "  \
    --train_file $DATA/train.ru.translationese.json \
    --validation_file $DATA/dev.ru.json \
    --test_file $DATA/test.ru.json \
    --output_dir $OUT/model-ru \
    --per_device_train_batch_size 8 \
    --per_device_eval_batch_size 8 \
    --max_tokens_per_batch 1024 \
    --gradient_accumulation_steps 128 \
    --max_source_length 128 \
    --max_target_length 128 \
    --max_steps 200 \
    --learning_rate 0.0007 \
    --num_beams 5 \
    --adafactor \
    --load_best_model_at_end \
    --save_strategy steps \
    --evaluation_strategy steps \
    --save_steps 10 \
    --eval_steps 10 \
    --overwrite_output_dir \
    --predict_with_generate
    
    

    
