/* Rede Credencia */
SELECT 	TRIM(TIPO) TIPO,  
		TRIM(codrda) CODRDA, 
		TRIM(nome_rda) NOME, 
	    TRIM(especialidade) ESPECIALIDADE, 
	    TRIM(endereco) ENDERECO, 
	    TRIM(numero) NUMERO, 
	    TRIM(complemento) COMPLEMENTO, 
	    TRIM(nome_municipio) MUNICIPIO, 
	    TRIM(nome_bairro) BAIRRO, 
	    TRIM(telefones) TELEFONES 
FROM SIGA.ORIENTADOR_MEDICO_CONTING 
/* WHERE OPERADORA = 'INTEGRAL' 
   AND TRIM(NOME_MUNICIPIO) = TRIM(nvl('"+strMunicipio+"', NOME_MUNICIPIO)) 
   AND TRIM(NOME_BAIRRO) = TRIM(nvl('"+strBairro+"', NOME_BAIRRO)) 
   AND TRIM(ESPECIALIDADE) = TRIM(nvl('"+strEspecialidade+"', ESPECIALIDADE)) 
   AND TRIM(TIPO) = TRIM(nvl('"+strTipo+"', TIPO)) 
   AND COD_PLANO = TRIM(NVL('"+strPlano+"',COD_PLANO)) 
   AND NOME_RDA LIKE '%"+strNome+"%'  */
 ORDER BY 3