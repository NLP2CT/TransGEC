# --- train and eval ---
BERT_BASE_DIR=/Your-path/chinese_L-12_H-768_A-12
DATA_DIR=/Your-path/train_data-zh

CUDA_VISIBLE_DEVICES=0 python /Your-path/bert-tf/run_classifier.py  \
  --task_name=translationese \
  --do_train=true \
  --do_eval=true \
  --do_lower_case=False \
  --data_dir=$DATA_DIR \
  --vocab_file=$BERT_BASE_DIR/vocab.txt \
  --bert_config_file=$BERT_BASE_DIR/bert_config.json \
  --init_checkpoint=$BERT_BASE_DIR/bert_model.ckpt \
  --max_seq_length=128 \
  --train_batch_size=32 \
  --learning_rate=5e-5 \
  --num_train_epochs=2.0 \
  --output_dir=/Your-path/out-zh-model | tee /Your-path/out-zh-model/validate_result.txt
  
   
  
      
   
