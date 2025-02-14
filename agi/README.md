# build the image

```
sudo docker build -t torch_ubuntu .
```
# open as a devcontainer in vscode

1) open the folder in vscode and rebuild in container with CTRL+SHIFT+P

2) in order for pylance to find all venv modules when analyzing the code, select the appropriate interpreter. To achieve that, use CTRL+SHIFT+P, enter `interpreter` in the command palette, then choose `/ve`

![](images/select_interpreter.png)

# download the model and test

```
ollama pull deepseek-r1:1.5b
```

```
ollama run deepseek-r1:1.5b "tu parles français ?"
ollama run deepseek-r1:1.5b "factorise l'équation 3x^2 + 5x - 2"
```


