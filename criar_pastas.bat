@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: =========================================================
:: Script para criar a estrutura de pastas do 2-Termo
:: e organizar aulas dentro de cada categoria
:: =========================================================

set "BASE=C:\Users\51446093840\Downloads\Curso-Dev\2-Termo"

:: Cria a estrutura base de categorias, caso ainda nao exista
if not exist "%BASE%" mkdir "%BASE%"
if not exist "%BASE%\APLICATIVOS [GERAL]" mkdir "%BASE%\APLICATIVOS [GERAL]"
if not exist "%BASE%\BACKEND [JAVASCRIPT]" mkdir "%BASE%\BACKEND [JAVASCRIPT]"
if not exist "%BASE%\BANCO DE DADOS [MYSQL, SQL]" mkdir "%BASE%\BANCO DE DADOS [MYSQL, SQL]"
if not exist "%BASE%\LIMA [HTML, CSS]" mkdir "%BASE%\LIMA [HTML, CSS]"
if not exist "%BASE%\PROJETOS [GERAL]" mkdir "%BASE%\PROJETOS [GERAL]"

:MENU
cls
echo ===================================================
echo         CRIADOR DE PASTAS - 2-Termo
echo ===================================================
echo.
echo Escolha a categoria onde deseja criar a pasta da aula:
echo.
echo   1 - APLICATIVOS [GERAL]
echo   2 - BACKEND [JAVASCRIPT]
echo   3 - BANCO DE DADOS [MYSQL, SQL]
echo   4 - LIMA [HTML, CSS]
echo   5 - PROJETOS [GERAL]
echo   0 - Sair
echo.
set /p OPCAO="Digite o numero da categoria: "

if "%OPCAO%"=="1" set "CATEGORIA=APLICATIVOS [GERAL]" & goto PERGUNTA_AULA
if "%OPCAO%"=="2" set "CATEGORIA=BACKEND [JAVASCRIPT]" & goto PERGUNTA_AULA
if "%OPCAO%"=="3" set "CATEGORIA=BANCO DE DADOS [MYSQL, SQL]" & goto PERGUNTA_AULA
if "%OPCAO%"=="4" set "CATEGORIA=LIMA [HTML, CSS]" & goto PERGUNTA_AULA
if "%OPCAO%"=="5" set "CATEGORIA=PROJETOS [GERAL]" & goto PERGUNTA_AULA
if "%OPCAO%"=="0" goto FIM

echo.
echo Opcao invalida! Tente novamente.
pause
goto MENU

:PERGUNTA_AULA
:: Conta quantas aulas ja existem na categoria escolhida
set "CONTADOR=0"
for /f %%A in ('dir /b /ad "%BASE%\%CATEGORIA%\Aula*" 2^>nul ^| find /c /v ""') do set "CONTADOR=%%A"
set /a PROXIMA=CONTADOR+1

echo.
echo Categoria: %CATEGORIA%
echo Aulas ja criadas nesta categoria: %CONTADOR%
echo Sugestao para continuar a sequencia: Aula [%PROXIMA%]
echo.
set /p NUMERO="Digite o numero da aula: "

if "%NUMERO%"=="" (
    echo.
    echo O numero da aula nao pode ser vazio!
    pause
    goto PERGUNTA_AULA
)

set "AULA=Aula [%NUMERO%]"

set "DESTINO=%BASE%\%CATEGORIA%\%AULA%"

if exist "%DESTINO%" (
    echo.
    echo A pasta "%AULA%" ja existe em "%CATEGORIA%".
) else (
    mkdir "%DESTINO%"
    echo.
    echo Pasta criada com sucesso em:
    echo %DESTINO%
)

:: Abre a pasta criada automaticamente no Explorador de Arquivos
start "" explorer "%DESTINO%"

:: Abre todo o 2-Termo no Visual Studio Code
start "" code "%BASE%"

echo.
set /p OUTRA="Deseja criar outra pasta? (S/N): "
if /i "%OUTRA%"=="S" goto MENU

:FIM
echo.
echo Encerrando o script. Ate a proxima!
pause
endlocal
