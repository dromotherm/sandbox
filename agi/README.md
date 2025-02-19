# build the image

```
sudo docker build -t torch_ubuntu .
```
`LANG=C.UTF-8` has been added as an environment variable in order to have french special char in the prompt (ç,é....)

# open as a devcontainer in vscode

dont forget to install NVIDIA Container Toolkit on the host !

1) open the folder in vscode and rebuild in container with CTRL+SHIFT+P

2) in order for pylance to find all modules installed in the venv when analyzing the code, we have to select the appropriate interpreter. To achieve that, use CTRL+SHIFT+P, enter `interpreter` in the command palette, then choose `/ve`

![](images/select_interpreter.png)

# download the model and test

```
ollama pull deepseek-r1:1.5b
```

```
ollama run deepseek-r1:1.5b "tu parles français ?"
ollama run deepseek-r1:1.5b "factorise l'équation 3x^2 + 5x - 2"
```


