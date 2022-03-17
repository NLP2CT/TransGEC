fairseq-interactive $PATH_TO_FOLDER/bin \
                 --path $PATH_TO_MODEL \
                 --input $PATH_TO_FOLDER/test.bpe.src" \
                 --buffer-size 1024 \
                 --batch-size 64 \
                 --log-format simple \
                 --beam 12 --lenpen 0.6 \
                 --remove-bpe \
                 | tee > $PATH_TO_OUT
                                  
cat $PATH_TO_OUT | grep -P '^H' | sort -nr -k1.2 | cut -f3- > $PATH_TO_OUT.hyp  


python /script/tokenization/pkunlp/detok_zh.py $PATH_TO_OUT.hyp $PATH_TO_OUT.hyp.detok
# pkunlp
python /pkunlp/pku_tok.py $PATH_TO_OUT.hyp.detok $PATH_TO_OUT.hyp.pku.tok 
python2 /evaluation_scorer/m2scorer/scripts/m2scorer.py  -v $PATH_TO_OUT.hyp.pku.tok $PATH_TO_M2 | tee $PATH_TO_OUT.score 
