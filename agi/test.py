from datasets import load_dataset

dataset_name = "ruslanmv/ai-medical-chatbot"
dataset = load_dataset(dataset_name, split="all")

print(dataset[0])