/*
±±?Desc. = Ponto de entrada para alteracao de dados antes da impressao?±±
±±? = Chamado 2x. Na exp. cc como rda e na exp. RDA ?±±
±±?Uso = Mobile Saude ?±±   
EXPOGM20
trocar na geracao do arquivo de tipo de rede os diversos nomes de consultorio 
COA	CONSULTORIO AED                         
COF	CONSULTORIO PESSOA FISICA               
COJ	CONSULTORIO PESSOA JURIDICA             
CON	CONSULTORIO                             
para apenas 
CONSULTORIO         

trocar na geracao do arquivo de tipo de rede os diversos nomes de consultorio 
NUP NUPRE                          
para apenas 
POLICLINICA
*/
User Function MBEXPRDA()                                                      
Local aArray := paramixb[1]
Local cTabPos := paramixb[2]
Local nCont := 1

If cTabPos <> "BC1" //BC1 = exp. Corpo clinico como RDA / QRYPRIN = exportacao RDA.   
   //3 é a posição do array 
  If aArray[3,2] $ "COA/COF/COJ/CON" //apenas referencial para saber o que eh cada elemento
    aArray[3,2] := "CON" //Posicao 2 - conteudo q sera exportado.
  Endif	     
  //Motta 17/1/18
  If aArray[3,2] $ "POL/NUP" //apenas referencial para saber o que eh cada elemento
    aArray[3,2] := "POL" //Posicao 2 - conteudo q sera exportado.
  Endif	
Endif    

Return aArray