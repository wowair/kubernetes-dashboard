port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram, compile, compiler)
import Home.Styles as HomeCSS
import Shared.Styles as SharedCSS


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "index.css", compile [ HomeCSS.css, SharedCSS.css ] ) ]


main : CssCompilerProgram
main =
    compiler files fileStructure
