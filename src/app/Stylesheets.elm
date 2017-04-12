port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram, compile, compiler)
import ViewCss


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "index.css", compile [ ViewCss.css ] ) ]


main : CssCompilerProgram
main =
    compiler files fileStructure
