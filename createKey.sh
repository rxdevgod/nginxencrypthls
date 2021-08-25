# CREATE KEY
openssl rand 16 > enc.key

# FILE -> tier01.keyinfo
echo "http://139.59.114.247:8080/enc.key" > tier01.keyinfo
echo "enc.key" >> tier01.keyinfo
echo `openssl rand -hex 16` >> tier01.keyinfo
