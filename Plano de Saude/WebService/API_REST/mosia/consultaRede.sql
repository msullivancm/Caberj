SELECT DISTINCT     
      'CABERJ' OPERADORA,
      X5_DESCRI TIPO, 
      BAQ_DESCRI ESPECIALIDADE,
      BAU_CODIGO CODRDA,
      NVL(TRIM(BAU_NFANTA),BAU_NOME) AS NOME_RDA,
      BAU_NOME RAZAO_SOCIAL_RDA,
      BAU_CPFCGC CNPJ_CGC,
      BAU_TIPPE TIPO_PESSOA,
      TRIM(BB8.BB8_MUN)  NOME_MUNICIPIO  , 
      (CASE WHEN (BB8_CODMUN = '3304557' AND (BB8_BAIRRO LIKE '%JACAREP%'   OR
                                              BB8_BAIRRO LIKE 'ANIL%'   OR
                                              BB8_BAIRRO LIKE '%CIDADE%DEUS%'   OR
                                              BB8_BAIRRO LIKE '%COLONIA%'   OR
                                              BB8_BAIRRO LIKE '%CURICICA%'   OR
                                              BB8_BAIRRO LIKE '%FREGUESIA%J%'   OR
                                              BB8_BAIRRO LIKE '%GARD%AZUL%'   OR
                                              BB8_BAIRRO LIKE '%PECHINCHA%'   OR
                                              BB8_BAIRRO LIKE '%PR%SECA%'   OR
                                              BB8_BAIRRO LIKE '%RIO GRANDE%'   OR
                                              BB8_BAIRRO LIKE '%TANQUE%'   OR
                                              BB8_BAIRRO LIKE '%TAQUARA%'   OR
                                              BB8_BAIRRO LIKE '%VL%VALQUEIRE%')) THEN 'JACAREPAGUA'
            WHEN (BB8_CODMUN = '3304557' AND (BB8_BAIRRO LIKE '%GOVER%'   OR
                                              BB8_BAIRRO LIKE '%BANCARIOS%'   OR
                                              BB8_BAIRRO LIKE '%BANANAL%'   OR
                                              BB8_BAIRRO LIKE '%CACUIA%'   OR       
                                              BB8_BAIRRO LIKE '%COCOTA%'   OR
                                              BB8_BAIRRO LIKE '%FREGUESIA%I%'   OR  
                                              BB8_BAIRRO LIKE '%GALEAO%'   OR   
                                              BB8_BAIRRO LIKE '%GUARABU%'   OR   
                                              BB8_BAIRRO LIKE '%ITACOLOMI%'   OR
                                              BB8_BAIRRO LIKE '%J%CARIOCA%'   OR         
                                              BB8_BAIRRO LIKE '%GUANABARA%'   OR  
                                              BB8_BAIRRO LIKE '%MONERO%'   OR  
                                              BB8_BAIRRO LIKE '%PITANGUEIRAS%'   OR         
                                              BB8_BAIRRO LIKE '%PORTUGUESA%'   OR        
                                              BB8_BAIRRO LIKE 'PR%%BANDEIRA%'   OR        
                                              BB8_BAIRRO LIKE '%RIBEIRA%'   OR  
                                              BB8_BAIRRO LIKE '%TAUA%'   OR         
                                              BB8_BAIRRO LIKE '%TUBIACANGA%'   OR         
                                              BB8_BAIRRO LIKE '%VILLAGE%'   OR  
                                              BB8_BAIRRO LIKE '%ZUMBI%')) THEN 'ILHA DO GOVERNADOR'  
            ELSE TRIM(BB8_BAIRRO) END) NOME_BAIRRO , 
      TRIM(BB8_END) ENDERECO ,
      TRIM(BB8_NR_END) NUMERO,
      TRIM(BB8_COMEND) COMPLEMENTO,
      BB8_TEL AS TELEFONES ,
      BAU_DTINCL INCLUSAO,
      BB8_EST AS UF  ,
      (SELECT BID_YDDD FROM BID010 WHERE BID_FILIAL=' ' AND BID_CODMUN=BB8_CODMUN AND D_E_L_E_T_=' ') AS DDD ,
      DECODE(BB8_CODMUN,'3304557',0,1) ORDEM,
      TRIM(BI5_DESCRI) REDE ,
      BI3_CODIGO COD_PLANO,
      BI3_NREDUZ NOME_PLANO,
      BI3_SUSEP NUM_REG_ANS,
      BAU_PRDATN PRDATN,
      BAU_SECRES SECRES,
      BAU_XDVPRO DVPRO,
      BB8_CODLOC CODLOC,
      BI5_CODRED CODRED,
      DECODE(TRIM(BAU_SECRES),'1','REDE PREFERENCIAL','2','REDE CREDENCIADA',BAU_SECRES) SEGMENT_REDE,
      BAQ_CODESP CODESP,
      CODSUB,
      DESCRISUB
    FROM  %table:BI5% BI5, 
          %table:BBK% BBK,
          %table:BAU% BAU,  
          %table:BB8% BB8, 
          %table:BAX% BAX, 
          %table:BAQ% BAQ, 
          %table:SX5% SX5,
          %table:BB6% BB6, 
          %table:BI3% BI3, 
          V_SUB_BAX_CAB VSUB
    WHERE BI5.BI5_CODRED = BBK.BBK_CODRED 
      AND BB8_EST=NVL(TRIM('RJ'),BB8_EST)   
      AND BB8_CODMUN = NVL(TRIM(''),BB8_CODMUN)  
      AND BAQ_YGPESP = NVL(TRIM(''),BAQ_YGPESP)
      AND INSTR(NVL(TRIM(''),BAQ_CODESP),BAQ_CODESP) > 0 
      AND BI5.D_E_L_E_T_ = BBK.D_E_L_E_T_  
      AND BBK.BBK_CODIGO = BAU.BAU_CODIGO  
      AND BBK.D_E_L_E_T_ = BAU.D_E_L_E_T_  
      AND BAU.BAU_CODIGO = BB8.BB8_CODIGO  
      AND BAU.D_E_L_E_T_ = BB8.D_E_L_E_T_  
      AND BB8.BB8_CODIGO = BAX.BAX_CODIGO  
      AND BB8.BB8_CODLOC = BAX.BAX_CODLOC  
      AND BB8.D_E_L_E_T_ = BAX.D_E_L_E_T_  
      AND BAX.BAX_CODINT = BAQ.BAQ_CODINT  
      AND BAX.BAX_CODESP = BAQ.BAQ_CODESP  
      and BAX.BAX_CODESP = BBK_CODESP
      and BAX.BAX_CODLOC = BBK_CODLOC
      AND BAX.D_E_L_E_T_ = BAQ.D_E_L_E_T_  
      AND BI5.%notDel%
      AND BB6_FILIAL = '  '
      AND BB6_CODRED = BI5_CODRED
      AND BI3_FILIAL = '  '
      AND BB6_CODIGO = BI3_CODINT||BI3_CODIGO 
      AND BI3_DATBLO = ' '
      AND BB6.%notDel%
      AND BI3.%notDel%
      AND BB8_DATBLO = '        ' 
      AND BAX_DATBLO = '        ' 
      AND BI3_PORTAL <> '2'
      AND BB8_GUIMED = '1'  
      AND BAX_GUIMED = '1'   
      AND BAU_GUIMED <> '0'  
      AND BAU_CODBLO = ' '  
      AND BAU_DATBLO = ' ' 
      AND BAQ_YDIVUL = '1'
      AND BAQ_ENVGUI = '1'
      AND BBK_YDIVUL = '1' 
      AND X5_TABELA ='97'
      AND X5_CHAVE=BAQ_YGPESP
      AND VSUB.CODRDA (+) = BAX_CODIGO
      AND VSUB.CODESP (+) = BAX_CODESP 