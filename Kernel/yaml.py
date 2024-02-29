import yaml
import json

def importyaml(file):
    with open(file, 'r') as stream:
        return yaml.load(stream, Loader=yaml.Loader)
    
        
def exportyaml(file, data):
    with open(file, 'w') as stream:
        jsn = json.loads(json.dumps(data))
        yaml.dump(jsn, stream, Dumper=yaml.Dumper, allow_unicode=True)
    return file    