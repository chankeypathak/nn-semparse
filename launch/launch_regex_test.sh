#!/usr/bin/env bash
if [ -z $2 ]
then
  echo "Usage: $0 [hidden layer size] [word embedding size]" 1>&2
  exit 1
fi
d=$1
i=$2 
device=cpu
num_cpu=4
#flags='--request-docker-image codalab/theano-cuda7.0-352.39'
cl run :src :lib :evaluator :regex "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32 python src/py/main.py -d $d -i $i -o $i -u 1 -t 25,5,5 -c lstm -m encoderdecoder --stats-file stats.json --domain regex --dev-seed 0 --model-seed 1 --train-data regex/regex_train_all.tsv --dev-data regex/regex_test.tsv --save-file params" --request-docker-image robinjia/robinjia-codalab --request-queue jag --request-cpus $num_cpu -n regex_test -d "encDec, no aug"
sleep 1
cl run :src :lib :evaluator :regex "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32 python src/py/main.py -d $d -i $i -o $i -u 1 -t 25,5,5 -c lstm -m encoderdecoder --stats-file stats.json --domain regex -a conj:500 --dev-seed 0 --model-seed 1 --train-data regex/regex_train_all.tsv --dev-data regex/regex_test.tsv --save-file params" --request-docker-image robinjia/robinjia-codalab --request-queue jag --request-cpus $num_cpu -n regex_test -d "encDec, conj:500"
sleep 1
cl run :src :lib :evaluator :regex "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32 python src/py/main.py -d $d -i $i -o $i -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --dev-seed 0 --model-seed 1 --train-data regex/regex_train_all.tsv --dev-data regex/regex_test.tsv --save-file params" --request-docker-image robinjia/robinjia-codalab --request-queue jag --request-cpus $num_cpu -n regex_test -d "attnBaseline, no aug"
sleep 1
cl run :src :lib :evaluator :regex "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32 python src/py/main.py -d $d -i $i -o $i -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex -a conj:500 --dev-seed 0 --model-seed 1 --train-data regex/regex_train_all.tsv --dev-data regex/regex_test.tsv --save-file params" --request-docker-image robinjia/robinjia-codalab --request-queue jag --request-cpus $num_cpu -n regex_test -d "attnBaseline, conj:500"
sleep 1
cl run :src :lib :evaluator :regex "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32 python src/py/main.py -d $d -i $i -o $i -p attention -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --dev-seed 0 --model-seed 1 --train-data regex/regex_train_all.tsv --dev-data regex/regex_test.tsv --save-file params" --request-docker-image robinjia/robinjia-codalab --request-queue jag --request-cpus $num_cpu -n regex_test -d "full, no aug"
sleep 1
cl run :src :lib :evaluator :regex "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32 python src/py/main.py -d $d -i $i -o $i -p attention -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex -a conj:500 --dev-seed 0 --model-seed 1 --train-data regex/regex_train_all.tsv --dev-data regex/regex_test.tsv --save-file params" --request-docker-image robinjia/robinjia-codalab --request-queue jag --request-cpus $num_cpu -n regex_test -d "full, conj:500"
sleep 1
