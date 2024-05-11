{% set models_to_generate = codegen.get_models(directory='fact', prefix='fct_') %}
{{ codegen.generate_model_yaml(
    model_names = models_to_generate
) }}