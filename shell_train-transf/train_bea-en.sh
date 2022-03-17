# --- train for BEA2109 English

for style in base native mix trans
do
  for seed in $seed1 $seed2 $seed3
  do

CUDA_VISIBLE_DEVICES=0,1 MKL_THREADING_LAYER=GNU fairseq-train $PATH_TO_MODEL/$style/bin \
    --arch transformer_wmt_en_de \
    --share-all-embeddings \
    --ddp-backend=no_c10d \
    --source-lang src --target-lang tgt \
    --lr-scheduler inverse_sqrt \
    --optimizer adam --adam-betas '(0.9, 0.98)' \
    --clip-norm 0.0 \
    --warmup-updates 4000 \
    --weight-decay 0.0001 \
    --criterion label_smoothed_cross_entropy \
    --label-smoothing 0.1 \
    --lr 0.0007 \
    --dropout 0.1 \
    --attention-dropout 0.1 \
    --activation-dropout 0.1 \
    --max-tokens 16384 \
    --update-freq 2 \
    --max-update 30000 \
    --patience 8 \
    --log-interval 100 \
    --no-epoch-checkpoints \
    --keep-interval-updates 10 \
    --save-interval-updates 500 \
    --save-dir $PATH_TO_MODEL \
    --fp16 \
    --seed $seed

 do
do                