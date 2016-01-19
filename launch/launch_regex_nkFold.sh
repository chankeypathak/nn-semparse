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
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m encoderdecoder --stats-file stats.json --domain regex --train-data regex/regex_train_nkushman_fold0.tsv --dev-data regex/regex_test_nkushman_fold0.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold0 -d 'no augmentation' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m encoderdecoder --stats-file stats.json --domain regex --train-data regex-augmented/regex_train_nkushman_fold0_200str_200int.tsv --dev-data regex/regex_test_nkushman_fold0.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold0 -d '200 str + 200 int' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex/regex_train_nkushman_fold0.tsv --dev-data regex/regex_test_nkushman_fold0.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold0 -d 'no augmentation' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex-augmented/regex_train_nkushman_fold0_200str_200int.tsv --dev-data regex/regex_test_nkushman_fold0.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold0 -d '200 str + 200 int' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p attention -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex/regex_train_nkushman_fold0.tsv --dev-data regex/regex_test_nkushman_fold0.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold0 -d 'no augmentation' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p attention -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex-augmented/regex_train_nkushman_fold0_200str_200int.tsv --dev-data regex/regex_test_nkushman_fold0.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold0 -d '200 str + 200 int' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m encoderdecoder --stats-file stats.json --domain regex --train-data regex/regex_train_nkushman_fold1.tsv --dev-data regex/regex_test_nkushman_fold1.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold1 -d 'no augmentation' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m encoderdecoder --stats-file stats.json --domain regex --train-data regex-augmented/regex_train_nkushman_fold1_200str_200int.tsv --dev-data regex/regex_test_nkushman_fold1.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold1 -d '200 str + 200 int' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex/regex_train_nkushman_fold1.tsv --dev-data regex/regex_test_nkushman_fold1.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold1 -d 'no augmentation' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex-augmented/regex_train_nkushman_fold1_200str_200int.tsv --dev-data regex/regex_test_nkushman_fold1.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold1 -d '200 str + 200 int' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p attention -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex/regex_train_nkushman_fold1.tsv --dev-data regex/regex_test_nkushman_fold1.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold1 -d 'no augmentation' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p attention -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex-augmented/regex_train_nkushman_fold1_200str_200int.tsv --dev-data regex/regex_test_nkushman_fold1.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold1 -d '200 str + 200 int' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m encoderdecoder --stats-file stats.json --domain regex --train-data regex/regex_train_nkushman_fold2.tsv --dev-data regex/regex_test_nkushman_fold2.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold2 -d 'no augmentation' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m encoderdecoder --stats-file stats.json --domain regex --train-data regex-augmented/regex_train_nkushman_fold2_200str_200int.tsv --dev-data regex/regex_test_nkushman_fold2.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold2 -d '200 str + 200 int' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex/regex_train_nkushman_fold2.tsv --dev-data regex/regex_test_nkushman_fold2.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold2 -d 'no augmentation' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p none -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex-augmented/regex_train_nkushman_fold2_200str_200int.tsv --dev-data regex/regex_test_nkushman_fold2.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold2 -d '200 str + 200 int' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p attention -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex/regex_train_nkushman_fold2.tsv --dev-data regex/regex_test_nkushman_fold2.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold2 -d 'no augmentation' $flags
sleep 1
cl run :src :lib :evaluator :regex :regex-augmented "OMP_NUM_THREADS=4 THEANO_FLAGS=blas.ldflags=-lopenblas,device=${device},floatX=float32,cuda.root=/usr/local/cuda-7.0 python src/py/main.py -d $d -i $i -o $i -p attention -u 1 -t 25,5,5 -c lstm -m attention --stats-file stats.json --domain regex --train-data regex-augmented/regex_train_nkushman_fold2_200str_200int.tsv --dev-data regex/regex_test_nkushman_fold2.tsv --save-file params" --request-queue jag --request-cpus $num_cpu -n regex_nkfold2 -d '200 str + 200 int' $flags