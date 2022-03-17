

# detokenize train/dev/test data for English, German, Russian and chinese.

perl /script/mosesdetokenizer.perl  -l en < gec-tokenized_data.en > gec-detokenized_data.en
perl /script/mosesdetokenizer.perl  -l de < gec-tokenized_data.de > gec-detokenized_data.de
perl /script/mosesdetokenizer.perl  -l ru < gec-tokenized_data.ru > gec-detokenized_data.ru

# chinese 

python python /script/tokenization/pkunlp/detok_zh.py  < gec-tokenized_data.zh > gec-detokenized_data.zh
