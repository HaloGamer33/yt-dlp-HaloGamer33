$invalidFormat = 0
$moreOptions = 0
$passthrough = 0
$worstFormatMenu = 0
$loop = 1

while ($loop -eq 1) {

    Write-Output ""
    Write-Output "-------------------------------------------------- YouTube Dowloader --------------------------------------------------"
    Write-Output ""


    $link = Read-Host "Youtube Link"
    Write-Output ""
    Write-Output "1. for Video + Audio."
    Write-Output "2. for only Video."
    Write-Output "3. for only Audio."
    Write-Output "4. for extra options."
    Write-Output ""

    $userInput = Read-Host "Choose Option"


    switch ($userInput) {
        1 { $format = "$null" }
        2 { $format = "-f bv" }
        3 { $format = "-f ba" }
        4 { $moreOptions = 1  }
        Default { $invalidFormat = 1 }
    }


    if ($moreOptions -eq 1) {
        Write-Output ""
        Write-Output "------------------------------------------------- Extra Options Menu --------------------------------------------------"
        Write-Output ""
        Write-Output "1. for worst formats."
        Write-Output "2. for list all formats."
        Write-Output "3. for clear log."
        Write-Output ""

        $userInput = Read-Host "Choose Option"


        switch ($userInput) {
            1 { $worstFormatMenu = 1 }
            2 { $waitForUserFormat = 1 }
            3 { Clear-Host ; $passthrough = 1 }
            Default { $invalidFormat = 1 }
        }

        
        if ($worstFormatMenu -eq 1) {
            Write-Output ""
            Write-Output "1. Worst Video + Audio"
            Write-Output "2. Worst Video"
            Write-Output "3. Worst Audio"
            Write-Output ""

            $userInput = Read-Host "Choose Option"

            switch ($userInput) {
                1 { $format = "-f w" }
                2 { $format = "-f wv" }
                3 { $format = "-f wa" }
                Default { $invalidFormat = 1 }
            }
        }


        switch ($waitForUserFormat) {
            1 {         
            Write-Output ""
            Write-Output "--------------------------------------------------- Custom Formats ----------------------------------------------------"
            Write-Output ""

            & .\yt-dlp.exe $link "--list-formats"

            Write-Output ""
            $customFormat = Read-Host "Choose your format number"
            $format = "-f $customFormat"
            }
            Default { $invalidFormat = 1 }
        }

    }

    if ($passthrough -ne 1) {

        Write-Output ""
        Write-Output "------------------------------------------------- Running YouTube-Dlp -------------------------------------------------"
        Write-Output ""


        & .\yt-dlp.exe $link $format


        if ($invalidFormat -eq 1) {

            Write-Host ""
            Write-Host "------------------------------------------------------- ERRORS --------------------------------------------------------"
            Write-Host ""
            Write-Host "You used an invalid format, the default format (Best video + Best audio merged) was used."

        }

        Write-Output ""
        Write-Output "--------------------------------------------------- End of Porgram ----------------------------------------------------"
        Write-Output ""

    }

    $loopProgramAsk = Read-Host "Repeat program? y/n"

    switch ($loopProgramAsk) {
        y { $loop = 1 }
        n { $loop = 0 }
        Default {}
    }

}

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
                                                  
                                                  


 Script by: HaloGamer 33 | Thanks for using.
"
Write-Output ""
Read-Host -Prompt "Press Enter to exit"