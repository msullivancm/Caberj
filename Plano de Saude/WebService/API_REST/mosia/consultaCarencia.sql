SELECT * FROM ( 
SELECT DISTINCT BAY_CODGRU CODIGO
     , BAT_DESCRI          DESCRICAO
     , BAE_CARENC 
     , BAE_UNCAR
     , DECODE(BAE_UNCAR,'1',CASE WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+1 > SYSDATE THEN
     'até '||TO_CHAR(TO_DATE(BA1_DATCAR,'YYYYMMDD')+1,'dd/mm/yyyy') WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+1 <= SYSDATE THEN 
     'até '||TO_CHAR(TO_DATE(BA1_DATCAR,'YYYYMMDD')+1,'dd/mm/yyyy')  END
     ,'2',CASE WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+BAE_CARENC  > SYSDATE THEN 
      'até '||TO_CHAR(TO_DATE(BA1_DATCAR,'YYYYMMDD')+BAE_CARENC,'dd/mm/yyyy') WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+BAE_CARENC <= SYSDATE THEN
  	'até '||TO_CHAR(TO_DATE(BA1_DATCAR,'YYYYMMDD')+BAE_CARENC,'dd/mm/yyyy') END) CARENCIA_ATE
                  FROM BA1010 BA1, BA3010 BA3, BAY010 BAY, BAT010 BAT, BAE010 BAE
                  WHERE
                    INSTR('" & EndVida__associado ',BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG) > 0
                    AND BA3_FILIAL = ' '
                    AND BA3_CODINT = BA1_CODINT
                    AND BA3_CODEMP = BA1_CODEMP
                    AND BA3_MATRIC = BA1_MATRIC
                    AND BAY_FILIAL = ' '
                    AND BAY_CODIGO = BA3_CODINT||BA3_CODPLA
                    AND BAY_VERSAO = BA3_VERSAO
                    AND BAE_FILIAL = ' '
                    AND BAE_CODIGO = BAY_CODIGO
                    AND BAE_VERSAO = BAY_VERSAO
                    AND BAE_CODGRU = BAY_CODGRU 
                    AND BAE_CARENC > 0
                    AND BAT_FILIAL = ' '
                    AND BAT_CODINT = SUBSTR(BAY_CODIGO,1,4)
                    AND BAT_CODIGO = BAY_CODGRU
                    AND NOT EXISTS (SELECT DISTINCT BA6_CODINT  
                                      FROM BA6010
                                     WHERE BA6_FILIAL = ' '
                                       AND BA6_CODINT = BA3.BA3_CODINT 
                                       AND BA6_CODIGO = BA3.BA3_CODEMP  
                                       AND BA6_NUMCON = BA1.BA1_CONEMP 
                                       AND BA6_VERCON = BA1.BA1_VERCON  
                                       AND BA6_SUBCON = BA1.BA1_SUBCON  
                                       AND BA6_VERSUB = BA1.BA1_VERSUB  
                                       AND BA6_CODPRO = BA3.BA3_CODPLA  
                                       AND BA6_CLACAR = BAE.BAE_CLACAR 
                                       AND BA6_CARENC = 0
                                       AND BA6010.D_E_L_E_T_ = ' ')
                    AND BA1_MOTBLO = '  '
                    AND DECODE(BAE_UNCAR,'1',CASE WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+1  > SYSDATE THEN 'EM CARENCIA'
                                                  WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+1 <= SYSDATE THEN 'CUMPRIDA' END
                                        ,'2',CASE WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+BAE_CARENC  > SYSDATE THEN 'EM CARENCIA'
                                         WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+BAE_CARENC <= SYSDATE THEN 'CUMPRIDA' END) = 'EM CARENCIA'
                    AND DECODE(BAE_UNCAR,'1',CASE WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+1  > SYSDATE THEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+1
                                                  WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+1 <= SYSDATE THEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+1 END
                                        ,'2',CASE WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+BAE_CARENC  > SYSDATE THEN
										  TO_DATE(BA1_DATCAR,'YYYYMMDD')+BAE_CARENC
                                                  WHEN TO_DATE(BA1_DATCAR,'YYYYMMDD')+BAE_CARENC <= SYSDATE THEN
												   TO_DATE(BA1_DATCAR,'YYYYMMDD')+BAE_CARENC END) > SYSDATE
                    AND BA1.D_E_L_E_T_ = ' '
                    AND BA3.D_E_L_E_T_ = ' '
                    AND BAT.D_E_L_E_T_ = ' '
                    AND BAY.D_E_L_E_T_ = ' '
                    AND BAE.D_E_L_E_T_ = ' '
               ORDER BY BAE_CARENC DESC, CODIGO DESC
                )  WHERE ROWNUM <= 3