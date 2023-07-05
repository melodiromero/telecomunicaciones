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

df_recursos          = pd.DataFrame() # Creacion del dataframe de recursos

dicc_recursos   = list()
dicc_recursos = resultado_api['resources'] if 'resources' in resultado_api else ['']

# Primer analisis: hay 4 tipos de recursos. ()
"""
| dt | tipo de recurso: conjunto de datos. |
| ds | tipo de recurso: vistas. |
| vz | tipo de recurso: visualizaciones. |
| db | tipo de recurso: colecciones. |
"""
print(type(dicc_recursos))
# Verifica si la respuesta es un diccionario
if isinstance(dicc_recursos, list):
    # Accede al array de recursos en el diccionario principal
    resources = dicc_recursos[0].get('resources', [])
    
    # Recorre cada diccionario en el array de recursos
    for item in resources:
         # Accede a las propiedades del diccionario de recursos y asigna los datos al dataframe df_recursos
        df_recursos['doc_type']             = item.get('doc_type')
        df_recursos['datastream_revision']  = item.get('datastream', {}).get('revision')
        df_recursos['parameters']           = item.get('parameters')
        df_recursos['h']                    = item.get('h')
        df_recursos['order']                = item.get('order')
        df_recursos['guid']                 = item.get('guid')
        df_recursos['type']                 = item.get('type')
        df_recursos['id']                   = item.get('id')
       
      
        
        # Imprime las propiedades
        print('Tipo de documento:', df_recursos['doc_type'])
        print('Revisión del flujo de datos:', df_recursos['datastream_revision'] )
    
       
else:
    print('La respuesta de la API no es un diccionario')

"""
# Verifica si la respuesta es una lista de diccionarios
if isinstance(dicc_recursos, list):
    # Recorre cada diccionario en la lista
    for item in dicc_recursos:
        # Accede a las propiedades del diccionario de recursos y asigna los datos al dataframe df_recursos
        df_recursos['doc_type']             = item.get('doc_type')
        df_recursos['datastream_revision']  = item.get('datastream', {}).get('revision')
        df_recursos['parameters']           = item.get('parameters')
        df_recursos['h']                    = item.get('h')
        df_recursos['order']                = item.get('order')
        df_recursos['guid']                 = item.get('guid')
        df_recursos['type']                 = item.get('type')
        df_recursos['id']                   = item.get('id')
       
        

        """
print(df_recursos)







