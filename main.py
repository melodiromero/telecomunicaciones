import requests
import pandas as pd

base_url = 'http://api.datosabiertos.enacom.gob.ar/api/v2/dashboards/ACCES-A-INTER.json/'

params   = dict(auth_key = 'HFW7mfXDUjdEh9d2kTqExJxw6hTPpj7AoxIFTNMc')
res      = requests.get(base_url, params=params)

resultado_api = res.json()  # Parsea la respuesta en formato JSON

df       = pd.DataFrame() # Creacion del dataframe principal

# Carga del dataframe principal
df['url_api']       = [base_url]  #  Url apuntando al recurso con los datos (archivos o página web)

# Verifica si la respuesta contiene la clave 'status'  Título del conjunto de datos
df['status']        = [resultado_api['status']] if 'status' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'endpoint'  Título del conjunto de datos
df['endpoint']      = [resultado_api['endpoint']] if 'endpoint' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'title'  Título del conjunto de datos
df['title']         = [resultado_api['title']] if 'title' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'parameters'
df['description']   = [resultado_api['parameters']] if 'parameters' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'category_name'
df['parameters']    = [resultado_api['category_name']] if 'category_name' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'tags' es un array de tags
df['tags']          = [resultado_api['tags']] if 'tags' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'last_revision_id' 
df['last_revision_id'] = [resultado_api['last_revision_id']] if 'last_revision_id' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'created_at' 
df['created_at']    = [resultado_api['created_at']] if 'created_at' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'modified_at' 
df['modified_at']   = [resultado_api['modified_at']] if 'modified_at' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'category_id'
df['category_id']   = [resultado_api['category_id']] if 'category_id' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'user' 
df['user']          = [resultado_api['user']] if 'user' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'category_name'
df['category_name'] = [resultado_api['category_name']] if 'category_name' in resultado_api else ['']

# Verifica si la respuesta contiene la clave 'link'
df['link']          = [resultado_api['link']] if 'link' in resultado_api else ['']

print(df.head())

df_recursos         = pd.DataFrame(columns=['doc_type', 'parameters', 'order', 'link', 'guid', 'type', 'id'])  # Creacion del dataframe de recursos

dicc_recursos       = resultado_api.get('resources', [])  # Inicializar dicc_recursos como una lista vacía si 'resources' no existe en resultado_api

# Primer análisis: hay 4 tipos de recursos.
"""
| dt | tipo de recurso: conjunto de datos. |
| ds | tipo de recurso: vistas. |
| vz | tipo de recurso: visualizaciones. |
| db | tipo de recurso: colecciones. |
"""

if dicc_recursos:
    print('pasa')

    # Recorre cada diccionario en el listado de recursos
    for elemento in dicc_recursos:
        # Asigna sus elementos al df_recurso
        nuevo_registro = {
            'doc_type'  : elemento['doc_type'],
            'parameters': elemento['parameters'],
            'order'     : elemento['order'],
            'link'      : elemento['link'],
            'guid'      : elemento['guid'],
            'type'      : elemento['type'],
            'id'        : elemento['id']
        }

        print(nuevo_registro)

        

else:
    print('La respuesta de la API no es un diccionario')

print(df_recursos)












