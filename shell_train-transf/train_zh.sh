for style in base native mix trans
do
  for seed in $seed1 $seed2 $seed3
  do

CUDA_VISIBLE_DEVICES=0,1,2,3 MKL_THREADING_LAYER=GNU fairseq-train $PATH_TO_MODEL/$style/bin \
    --arch transformer_wmt_en_de \
    --share-all-embeddings \
    --source-lang src --target-lang trg \
    --encoder-embed-dim 512 \
    --encoder-layers 6 --decoder-layers 6 \
    --encoder-attention-heads 8 \
    --decoder-attention-heads 8 \
    --encoder-ffn-embed-dim 2048 \
    --decoder-ffn-embed-dim 2048 \
    --optimizer adam --adam-betas '(0.9, 0.998)' \
    --clip-norm 0.0 \
    --lr-scheduler inverse_sqrt \
    --warmup-updates 8000 \
    --warmup-init-lr '1e-07' \
    --weight-decay 0.0001 \
    --criterion label_smoothed_cross_entropy \
    --label-smoothing 0.1 \
    --dropout 0.2 \
    --attention-dropout 0.1 \
    --activation-dropout 0.1 \
    --lr 0.0007 \
    --max-update 50000 \
    --max-tokens 8192 \
    --update-freq 2 \
    --save-interval-updates 1000 \
    --patience 10 \
    --log-interval 50 \
    --no-epoch-checkpoints \
    --keep-interval-updates 10 \
    --save-dir $output \
    --seed $seed 
  do
do

                  