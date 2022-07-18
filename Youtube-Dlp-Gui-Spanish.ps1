# ---------------------------------------------------------------------------- #
#                                Youtube Dlp Gui                               #
# ---------------------------------------------------------------------------- #

# ------------------------------- Loop Variable ------------------------------ #

# This variable is run outside the loop so that the code can start.

$loop = 1

# -------------------------------- Main Script ------------------------------- #

# Starting the loop so that the program can run until the user defines in doesnt wan to run it anymore in which case the variable $loop will be switched off ($loop = 0).

while ($loop -eq 1) {

    # --------------------------------- variables -------------------------------- #

    # Setting some variables so they are in their default state.

    $invalidFormat = 0
    $moreOptions = 0
    $passthrough = 0
    $worstFormatMenu = 0

    # ------------------------------- Starting Menu ------------------------------ #

    Write-Output ""
    Write-Output "-------------------------------------------------- YouTube Dowloader --------------------------------------------------"
    Write-Output ""

    # The program ask for the link of the youtube video to the user.

    $link = Read-Host "Link de Youtube"

    Write-Output ""
    Write-Output "1. para Video + Audio."
    Write-Output "2. para solo Video."
    Write-Output "3. para solo Audio."
    Write-Output "4. para mas opciones."
    Write-Output ""

    $userInput = Read-Host "Elije tu opcion."

    # The program uses a switch function to compare the user input, if the user input is invalid the program uses the default yt-dlp format and proceeds with the dowload.

    switch ($userInput) {
        1 { $format = "$null" }
        2 { $format = "-f bv" }
        3 { $format = "-f ba" }
        4 { $moreOptions = 1  }
        Default { $invalidFormat = 1 }
    }

    # ---------------------------- Extra Options Menu ---------------------------- #

    # If the user selected "4. for extra options" then the program displays the following:

    if ($moreOptions -eq 1) {

        Write-Output ""
        Write-Output "----------------------------------------------- Menú De Opciones Extra ------------------------------------------------"
        Write-Output ""
        Write-Output "1. para peores formatos."
        Write-Output "2. para listar todos los formatos."
        Write-Output "3. para limpiar la consola."
        Write-Output "4. para formatos directos de Yt-dlp."
        Write-Output ""

        $userInput = Read-Host "Elije tu opcion."

        switch ($userInput) {
            1 { $worstFormatMenu = 1 }
            2 { $waitForUserFormat = 1 }
            3 { Clear-Host ; $passthrough = 1 }
            4 { $directFormatMenu = 1 }
            Default { $invalidFormat = 1 }
        }

        # ---------------------------- Worst Formats Menu ---------------------------- #

        # If the user selected "1. for worst formats" the program displays the following;

        if ($worstFormatMenu -eq 1) {
            Write-Output ""
            Write-Output "1. Peor Video + Audio."
            Write-Output "2. Peor Video."
            Write-Output "3. Peor Audio."
            Write-Output ""

            $userInput = Read-Host "Elije Opcion."

            switch ($userInput) {
                1 { $format = "-f w" }
                2 { $format = "-f wv" }
                3 { $format = "-f wa" }
                Default { $invalidFormat = 1 }
            }
        }

        # --------------------------- List All Formats Menu -------------------------- #

        # If the user selected "2. for list all formats." the program displays the following:

        switch ($waitForUserFormat) {
            1 { 
                Write-Output ""
                Write-Output "---------------------------------------------- Formatos Personalizados ------------------------------------------------"
                Write-Output ""
    
                & .\yt-dlp.exe $link "--list-formats"
    
                Write-Output ""
                $customFormat = Read-Host "Elije el numero del formato deseado"
                $format = "-f $customFormat"

            }
            Default {$invalidFormat = 1}
        }

        # ---------------------------- Direct Format Menu ---------------------------- #

        # If the user selected "4. for direct youtube-dlp format." the program displays the following:
        
        switch ($directFormatMenu) {
            1 { 
                Write-Output ""
                Write-Output "----------------------------------------------- Formato Yt-Dlp directo ------------------------------------------------"
                Write-Output ""

                Write-Output "Esta seccion es para insertar formato de yt-dlp de manera directa. `n `nPuedes encontrar la información relacionada a los formatos de yt-dlp aquí: https://github.com/yt-dlp/yt-dlp#format-selection"
                Write-Output ""

                $format = Read-Host "Inserta el formato que gustas usar (Incluye -f)"

            }
            Default {$invalidFormat = 1}
        }
    }

    # ---------------------------------------------------------------------------- #
    #                                  Yt-Dlp.exe                                  #
    # ---------------------------------------------------------------------------- #

    # The $passthrough variable is there in order to make the "Clear log command function the right way" achived through a simple if check.

    if ($passthrough -ne 1) {

        # ------------------------- Yt-dlp.exe Initialization ------------------------ #

        # Yt-Dlp starts running with the user selected options.

        Write-Output ""
        Write-Output "-------------------------------------------------- Ejecutando Yt-Dlp --------------------------------------------------"
        Write-Output ""


        & .\yt-dlp.exe $link $format

        # ------------------------------ Errors Section ------------------------------ #

        # If during any point of selecting options the user inputed an invalid option the porgram runs the default dowload, this let the user know what happend.

        if ($invalidFormat -eq 1) {

            Write-Host ""
            Write-Host "------------------------------------------------------ ERRORES --------------------------------------------------------"
            Write-Host ""
            Write-Host "Usaste un formato invalido, el formato estandar (Mejor audio + Mejor video) fue usado."

        }

        # ------------------------------ End of Program ------------------------------ #

        # The program ends, and lets the user know.

        Write-Output ""
        Write-Output "-------------------------------------------------- Fin De Programa ----------------------------------------------------"
        Write-Output ""

    }

    # ------------------------------- Program Loop ------------------------------- #

    # If the user wants to re-run the program this line ask hims, if yes the $loop variable remains unchanged to simplify process if not, then the programs displays a goodbye message.
    
    $loopProgramAsk = Read-Host "Repetir el programa? s/n"

    switch ($loopProgramAsk) {
        s { $loop = 1 }
        n { $loop = 0 }
        Default {}
    }

}

# ---------------------------------------------------------------------------- #
#                                Goodbye Message                               #
# ---------------------------------------------------------------------------- #

# A goodbye message with some ascii art.

Write-Output ""
Write-Output "

                                                  
                                                  
                    .:^^  ^^:.                    
          .7:    :!!!!!!~~!!!!!!^    .7.          
         7#B.  ^7!~?P#&@@@@&#PJ~~7~   G&?         
       ^G@P. .?!^5&@@@@@@@@@@@@@P~~?:  5@B~       
      !&@G  :J:!&@@@@@@@@@@@@@@@@@?.J^  5@@?      
     7@@&: .Y.7@@@@@@@@@@@@@@@@@@@@J Y. .#@@J     
    !@@@J  7~:&@@@@@@@@@@@@@@@@@@@@@^^?  7@@@?    
   :#@@@^  . J@@@@@@@@@@@@@@@@@@@@@@5 .  .&@@@^   
   Y@@@&.    5@@@@@@@@@@@@@@@@@@@@@@G     B@@@P   
  .&@@@#.    Y@@@@@@@@@@@@@@@@@@@@@@P     B@@@@^  
  !@@@@@^  7!^@@@@@@@@@@@@@@@@@@@@@@!~J  .&@@@@?  
  ?@@@@@?  !&.J@@@@@@@@@@@@@@@@@@@@5 B?  !@@@@@Y  
  ?@@@@@&.  YG J@@@@@@@@@@@@@@@@@@5 5P   B@@@@@Y  
  !@@@@BJ.   YG:~G@@@@@@@@@@@@@@B!.P5    ?B@@@@J  
  :@&5~.~PY   !GJ:~5#@@@@@@@@#5~:?G?   ?G!.^Y&@~  
   !::JB@@@P.  .?PY  ^#@@@@&~  ?PJ.  .5@@@#Y^.!.  
    P@@@@@@@#7    ^.  7@@@@J   ^    !#@@@@@@@G.   
    J@@@@@@@@@Y       :&@@@^       J@@@@@@@@@5    
     5@@@@@@@@@P~     :&@@@~     ^5@@@@@@@@@G     
      Y@@@@@@@@@@G7   :&@@@~   !P@@@@@@@@@@P.     
       7&@@@@@@@@@@Y  :&@@@~  ?@@@@@@@@@@@?       
        :5@@@@@@@@@&: :&@@@~ .#@@@@@@@@@P^        
          ^5&@@@@@@@^ :&@@@~ .&@@@@@@@P~          
            :?G&@@@@^ :@@@@~ .&@@@&G?:            
               :!JPB: .PGGG^ .BGY!:               
                                                  
                                                  


 Script por: HaloGamer 33 | Gracias por usar.
"

# Thanks for using and thank you for checking my code out uwu. 

Write-Output ""
Read-Host -Prompt "Presiona Enter para salir"