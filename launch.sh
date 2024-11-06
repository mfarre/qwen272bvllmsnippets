#!/bin/bash
#SBATCH --job-name=vllm-qwen2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1          # crucial - only 1 task per dist per node!
#SBATCH --cpus-per-task=64           # Keep <=64 to enable "mix" sharing of resources
#SBATCH --gres=gpu:8
#SBATCH --exclusive
#SBATCH --partition=hopper-prod
#SBATCH --qos=high
#SBATCH --output=/fsx/miquel/qwen2-72b/logs/%x-%j.out
#SBATCH --err=/fsx/miquel/qwen2-72b/logs/%x-%j.err

set -x -e
source ~/.bashrc
export HF_HOME=/fsx/miquel/cache

source /fsx/miquel/miniconda3/etc/profile.d/conda.sh 
conda activate vllm


echo "START TIME: $(date)"

# Load required modules (adjust based on your cluster setup)
module load cuda/12.1


# Set environment variables
# export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
# export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512

# Run VLLM server
srun python -m vllm.entrypoints.openai.api_server \
    --model Qwen/Qwen2-VL-72B-Instruct \
    --tensor-parallel-size 8 \
    --gpu-memory-utilization 0.95 \
    --max-num-batched-tokens 131072 \
    --dtype bfloat16 \
    --host 0.0.0.0 \
    --port 8000