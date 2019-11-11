(function(){
    var oldLog = console.log;
    console.log = function (message){
        if(typeof(message) == 'object')
            document.getElementById('consolelog').innerHTML = document.getElementById('consolelog').innerHTML + JSON.stringify(message) + "<br>"
        else
            document.getElementById('consolelog').innerHTML = document.getElementById('consolelog').innerHTML + message + "<br>"
        $("#consolelog").scrollTop($("#consolelog")[0].scrollHeight);
        oldLog.apply(undefined, undefined);
    };
})();

$(window).on("error", function(evt) {
    var e = evt.originalEvent;
    if (e.message) { 
        console.log("Error: " + e.message + "<br> Line: " + e.lineno);
    } else {
        cnosole.log("Error: " + e.type + "<br>Element: " + (e.srcElement || e.target));
    }
});


var num_paginas_atual = 0;
const items = document.body.getElementsByTagName("*");
var elementosDaDiv = [];
var temText = 0;
var newDiv;
var pagina_atual = 1;
var divCodeMirror;
var disabledVolta = true;
var disabledAvanca = false;

function fullScreenConsolelog(){
    $('.exercicio'+pagina_atual).css('display', 'none');
    $('#volta').attr('disabled', true);
    $('#avanca').attr('disabled', true);
    $('#consolelog').css('width', '100%');
    $('#fullScreenConsole').attr('onClick', 'javascript: voltaConsolelogAoNormal()');
    $('#fullScreenConsole').attr('value', 'Normal');
    $('#fullScreenConsole').css('margin-left', '94%');
    //console.log("Aumentou o console");
}

function voltaConsolelogAoNormal(){
    $('#consolelog').css('width', '33.33%');
    $('.exercicio'+pagina_atual).css('display', 'inline');
    $('#volta').attr('disabled', disabledVolta);
    $('#avanca').attr('disabled', disabledAvanca);
    $('#fullScreenConsole').attr('onClick', 'javascript: fullScreenConsolelog()');
    $('#fullScreenConsole').attr('value', 'Tela Cheia');
    $('#fullScreenConsole').css('margin-left', '83%');
    //console.log("Diminuiu o console");
}

function aplicaEstiloTres(divAtual, indice){
    divAtual.className += ("exercicio"+indice);
    divAtual.style.verticalAlign = "top";
    divAtual.style.width = "33.33%";
    divAtual.style.padding = "5px";
    divAtual.style.float = "left";
    divAtual.style.position = "relative";
    divAtual.style.backgroundColor = "black";
    divAtual.style.overflow = "auto";
    //console.log("Aplicou estilo de tres");
    //texto[0].style.height = "535px";
    //texto[0].style.float = "left";
    divAtual.className += (" temEditor texto");
}

function aplicaEstilo(divAtual, indice){
    divAtual.style.width = "100%";
    divAtual.style.padding = "5px";
    divAtual.style.position = "relative";
    divAtual.style.backgroundColor = "black";
    divAtual.style.float = "left";
    divAtual.style.overflow = "auto";
    divAtual.className += ("exercicio"+indice + " texto");
    //console.log("Aplicou estilo de um");
}

function preparaLayout(){
    $(".exercicio1").css('display', 'inline');
    if($("#exercicio1").hasClass("temEditor")){
        $("#consolelog").css('display', 'inline');
    }
    else{
        $("#consolelog").css('display', 'none');
    }
    for(var i = 2; i <= num_paginas_atual; i++){
        $(".exercicio"+i).css('display', 'none');
    }
    
    $('#volta').attr('disabled', 'true');
    $(".CodeMirror").css('width', '33%');
    $(".CodeMirror").css('float', 'left');
}

function aninhaConteudo(){
    for (var i = 0, len = items.length; i < len; i++) {
        //console.log(items[i].nodeName);
        len = items.length;
        if(items[i].nodeName == "H2"){
            //console.log(items[i].nodeName + " " + items[i].id + " ");
            if(elementosDaDiv.length > 0) {
                for(var k = 0, elen = elementosDaDiv.length; k < elen; k++){
                    if(elementosDaDiv[k].nodeName == "DIV" && elementosDaDiv[k].className == "CodeMirror cm-s-default"){
                        divCodeMirror = '<div id = "editor'+num_paginas_atual+'"></div>';
                        newDiv.insertAdjacentHTML('afterend', divCodeMirror);
                        divCodeMirror = document.getElementById("editor"+num_paginas_atual)
                        divCodeMirror.append(elementosDaDiv[k]);
                        //divCodeMirror.append(elementosDaDiv[k+1]);
                        //newDiv.after(elementosDaDiv[k]);
                        //newDiv.insertAdjacentHTML('afterend', elementosDaDiv[k]);
                        divCodeMirror.className += (" exercicio"+num_paginas_atual);
                        divCodeMirror.className += (" editor");
                        //console.log("adicionou elementos");
                        //k = k+2;
                        k++;
                        while(!(elementosDaDiv[k].nodeName == "BUTTON" && elementosDaDiv[k].className == "go")){
                            divCodeMirror.append(elementoDaDiv[k]);
                            k++;
                        }
                        k = k - 1;    
                    }
                    else{
                        if(elementosDaDiv[k].nodeName == "BUTTON" && elementosDaDiv[k].className == "go"){
                            divCodeMirror.append(elementosDaDiv[k]);
                            elementosDaDiv[k].className += (" exercicio"+num_paginas_atual);
                            //console.log("adicionou botão");
                        }
                        else{
                            newDiv.append(elementosDaDiv[k]);
                        }
                    }
                }
                if(temText == 1){
                    aplicaEstiloTres(newDiv, num_paginas_atual);
                    temText = 0;
                }
                else{
                    aplicaEstilo(newDiv, num_paginas_atual);
                }
                while(elementosDaDiv.length > 0){
                    //console.log(elementosDaDiv.length);
                    elementosDaDiv.pop();                
                }
                //console.log("Tirou tudo");
            }
            num_paginas_atual++;
            //console.log(num_paginas_atual);
            //console.log(items[i].nodeName);
            while(items[i].nodeName == "TEXTAREA"){
                i++;
            }
            newDiv = '<div id = "exercicio'+num_paginas_atual+'"></div>';
            //console.log(newDiv);
            items[i].insertAdjacentHTML('beforebegin', newDiv);
            i++;
            //console.log(i);
            //console.log(items[i].nodeName);
            newDiv = document.getElementById("exercicio"+num_paginas_atual);
            elementosDaDiv.push(items[i]);
        }
        if(items[i].nodeName == "P" || items[i].nodeName == "IMG" || items[i].nodeName == "UL" || items[i].nodeName == "LI" || items[i].nodeName == "BUTTON" 
           || items[i].nodeName == "OL" || items[i].nodeName == "DT" || items[i].nodeName == "A" || items[i].nodeName == "BR" || items[i].nodeName == "TABLE"
           || items[i].nodeName == "COL" || items[i].nodeName == "COLGROUP" || items[i].nodeName == "THEAD" || items[i].nodeName == "TD"
           || items[i].nodeName == "AUDIO" || items[i].nodeName == "SOURCE" || items[i].nodeName == "VIDEO" || items[i].nodeName == "INPUT" 
           || items[i].nodeName == "SELECT" || items[i].nodeName == "OPTGROUP" || items[i].nodeName == "OPTION" || items[i].nodeName == "DATALIST" 
           || items[i].nodeName == "DETAILS" || items[i].nodeName == "SUMMARY" || items[i].nodeName == "OBJECT" || items[i].nodeName == "METER" 
           || items[i].nodeName == "PROGRESS" || items[i].nodeName == "FIGURE" || items[i].nodeName == "FIGCAPTATION" || items[i].nodeName == "AREA"
           || items[i].nodeName == "TIME" || items[i].nodeName == "MENU" || items[i].nodeName == "MENUITEM" || items[i].nodeName == "FORM" 
           || items[i].nodeName == "SVG" || items[i].nodeName == "RECT" || items[i].nodeName == "CIRCLE" || items[i].nodeName == "ELLIPSE"
           || items[i].nodeName == "TEXT" || items[i].nodeName == "LINE" || items[i].nodeName == "POLYLINE" || items[i].nodeName == "POLYGON"
            || items[i].nodeName == "H3" || items[i].nodeName == "H4" || items[i].nodeName == "H5" || items[i].nodeName == "H6"){
            //console.log(items[i].nodeName + " " + items[i].id);
            elementosDaDiv.push(items[i]);
        }
        if(items[i].nodeName == "DIV" && items[i].className == "CodeMirror cm-s-default"){
            //console.log(items[i].nodeName + " " + items[i].id);
            elementosDaDiv.push(items[i]);
            temText = 1;
        }
        if(items[i].nodeName == "DIV" && items[i].id == "consolelog" || items[i].nodeName == "FOOTER"){
            //console.log(items[i].nodeName + " " + items[i].id);
            for(var k = 0, elen = elementosDaDiv.length; k < elen; k++){
                if(elementosDaDiv[k].nodeName == "DIV" && elementosDaDiv[k].className == "CodeMirror cm-s-default"){
                    divCodeMirror = '<div id = "editor'+num_paginas_atual+'"></div>';
                    newDiv.insertAdjacentHTML('afterend', divCodeMirror);
                    divCodeMirror = document.getElementById("editor"+num_paginas_atual)
                    divCodeMirror.append(elementosDaDiv[k]);
                    //newDiv.after(elementosDaDiv[k]);
                    //newDiv.insertAdjacentHTML('afterend', elementosDaDiv[k]);
                    //elementosDaDiv[k].className += (" exercicio"+num_paginas_atual);
                    divCodeMirror.className += (" exercicio"+num_paginas_atual);
                    //console.log("adicionou elementos");
                }
                else{
                    if(elementosDaDiv[k].nodeName == "BUTTON" && elementosDaDiv[k].className == "go"){
                        //newDiv.nextSibling.after(elementosDaDiv[k]);
                        //newDiv.nextElementSibling.insertAdjacentHTML('afterend', elementosDaDiv[k]);                        
                        divCodeMirror.lastChild.after(elementosDaDiv[k]);
                        elementosDaDiv[k].className += (" exercicio"+num_paginas_atual);
                        //console.log("adicionou botão");
                        //elementosDaDiv[k].className += (" exercicio"+num_paginas_atual);
                        //console.log("adicionou botão");
                    }
                    else{
                        //console.log(items[i].id);
                        //console.log(items[i].className);
                        newDiv.append(elementosDaDiv[k]);
                    }
                }
            }
            if(temText == 1){
                aplicaEstiloTres(newDiv, num_paginas_atual);
                temText = 0;
            }
            else{
                aplicaEstilo(newDiv, num_paginas_atual);
            }
            while(elementosDaDiv.length > 0){
                elementosDaDiv.pop();                
            }
            i = len;
        }
    }
    
    preparaLayout();
}

function voltaTela(){
    var k = pagina_atual - 1;
    if(pagina_atual == 1){
        $('#volta').attr('disabled', true);
        disabledVolta = true;
        return;
    }
    if(pagina_atual == 2 && pagina_atual <= num_paginas_atual){
        $('#volta').attr('disabled', true);
        disabledVolta = true;
    }
    if(pagina_atual == num_paginas_atual){
        $('#avanca').attr('disabled', false);
        disabledAvanca = false;
    }
    $('.exercicio'+pagina_atual).css('display', 'none');
    $('.exercicio'+k).css('display', 'inline');
    pagina_atual = k;
    if($('#exercicio'+pagina_atual).hasClass("temEditor")){
        $("#consolelog").css('display', 'inline');
    }
    else{
        $("#consolelog").css('display', 'none');
    }
}

function avancaTela(){
    var k = pagina_atual + 1;
    if(pagina_atual == num_paginas_atual){
        $('#avanca').attr('disabled', true);
        disabledAvanca = true;
        return;
    }
    if(pagina_atual == 1){
        $('#volta').attr('disabled', false);
        disabledVolta = false;
    }
    if(k == num_paginas_atual){
        $('#avanca').attr('disabled', true);
        disabledAvanca = true;
    }
    $('.exercicio'+pagina_atual).css('display', 'none');
    $('.exercicio'+k).css('display', 'inline');
    pagina_atual = k;  
    if($('#exercicio'+pagina_atual).hasClass("temEditor")){
        $("#consolelog").css('display', 'inline');
    }
    else{
        $("#consolelog").css('display', 'none');
    }     
}

function zeraConsole(){    
    $("#consolelog").html("");
}

$(document).ready(function(){
    setTimeout(
        aninhaConteudo()
        , 0);
});

$("#volta").click(voltaTela);
$("#avanca").click(avancaTela);
$(".go").click(zeraConsole);
$("#fullScreenConsole").click(fullScreenConsolelog);
