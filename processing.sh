# data processing for English, Bea19 English, German, Russian, Chinese

for pat in base native mix trans
do
  
fairseq-preprocess \
    --source-lang src \
    --target-lang tgt \
    --trainpref $PATH_TO_FOLDER/$pat/train.bpe \
    --validpref $PATH_TO_FOLDER/$pat/dev.bpe \
    --testpref $PATH_TO_FOLDER/$pat/test.bpe \
    --joined-dictionary \
    --destdir $PATH_TO_DATA/bin \
    --workers 10

done

