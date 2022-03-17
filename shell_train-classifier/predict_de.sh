# --- predict --- 
# WMT Englsih->Geramn corpus only Geramn side, remember add any label to Geram side for classfy. 
# The text file name should be test.shuf, eg. /Your-path/WMT-Geramn-target-side/test.shuf

BERT_BASE_DIR=/Your-path/multi_cased_L-12_H-768_A-12
DATA_DIR=/Your-path/train_data-de
DATA=/Your-path/WMT-Geramn-target-side
  
UDA_VISIBLE_DEVICES=0 python $ROOT/tensor_bert/bert/run_ru_classifier.py \
  --task_name=translationese \
  --do_predict=true \
  --do_lower_case=False \
  --data_dir=$DATA_DIR \
  --vocab_file=$BERT_BASE_DIR/vocab.txt \
  --bert_config_file=$BERT_BASE_DIR/bert_config.json \
  --init_checkpoint=/Your-path/out-de-model/model.ckpt-xxx \
  --predict_batch_size=64 \
  --max_seq_length=128 \
  --output_dir=$DATA/  # a prob. file named test_results.tsv will poduced

# --- obtain translationese and native texts ---
paste $DATA/test_results.tsv $DATA/test.shuf > data_with_prob.txt
python /script/indentify.py data_with_prob.txt translationese.txt native_text.txt
  
      
  

