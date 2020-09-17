$(document).ready(() => {
    if (document.triplePage) {
        divideDocumentoEmPaginas();
        
        $('.pagina').each((i, elem) => {
            dividePaginaEmCorpoCodigoConsole($(elem));
        });

        criaPainel();

    }
    
    function criaPainel() {
        // TODO: expandeEditor
        let elem = $('<div class="painel">' +
            '<input type="button" class="btn-back" id="volta" value="Retroceder"/>' +
            '<input type="button" class="btn-fwd" id="avanca" value="Avançar"/>' +
            '<input type="button" id="expandeEditor" value="Expandir editor"/>' +
            '</div>');
            elem.addClass("painel");

        elem.prependTo($('body'));

        alteraPaginaAtual(0);

        $('.btn-back').click(() => alteraPaginaAtual(-1));
        $('.btn-fwd').click(() => alteraPaginaAtual(1));
        $('#expandeEditor').click(function () {
            // const elem = $('.pagina-codigo');
            $('.pagina-codigo').toggleClass('fullscreen');
            atualizaBotaoFullscreen();
            // const fullscreenClass = 'fullscreen';
            // if (elem.hasClass(fullscreenClass)) {
            //     elem.removeClass(fullscreenClass);
            // } else {
            //     elem.addClass(fullscreenClass);
            // }
        });
    }
    
    function atualizaBotaoFullscreen() {
        let elem = $('#expandeEditor');
        if ($('.fullscreen').length == 0) {
            elem.attr('value', 'Expandir editor');
        } else {
            elem.attr('value', 'Contrair editor');
        }
    }
    function alteraPaginaAtual(delta) {
        let atual = $('.pagina-atual');

        let proxima = undefined;
        if (delta < 0) {
            proxima = atual.prev('.pagina');
        } else if (delta > 0) {
            proxima = atual.next('.pagina');
        }
        
        if (proxima != undefined && proxima.length > 0) {
            atual.removeClass('pagina-atual');
            proxima.addClass('pagina-atual');
            atual = proxima;
        }

        // atualiza botões
        $('.btn-back').prop('disabled', atual.prev('.pagina').length == 0);
        $('.btn-fwd').prop('disabled', atual.next('.pagina').length == 0);

        // desativa fullscreen
        $('.fullscreen').removeClass('fullscreen');
        $('#expandeEditor').prop('disabled', atual.find('.code, .CodeMirror').length == 0);
        atualizaBotaoFullscreen();
    }

    function dividePaginaEmCorpoCodigoConsole(elemPagina) {
        let firstChild = elemPagina.children().first();
        let divPaginaCorpo = $('<div></div>');
        divPaginaCorpo.addClass('pagina-corpo');
        divPaginaCorpo.prependTo(elemPagina);
        
        moveElementAndSiblings({
            element: firstChild,
            destinationElement: divPaginaCorpo,
            stopOnSelector: '.code, .CodeMirror'
        });
        
        let divPaginaCodigo = $('<div></div>');
        divPaginaCodigo.addClass('pagina-codigo');
        divPaginaCodigo.insertAfter(divPaginaCorpo);
        firstChild = divPaginaCodigo.next();
        
        moveElementAndSiblings({
            element: firstChild,
            destinationElement: divPaginaCodigo,
            stopOnSelector: ':not(.code, .CodeMirror, .go)'
        });

        
        
        let divPaginaConsole = $('<div></div>');
        divPaginaConsole.addClass('pagina-console');
        divPaginaConsole.insertAfter(divPaginaCodigo);
        firstChild = divPaginaConsole.next();
        
        moveElementAndSiblings({
            element: firstChild,
            destinationElement: divPaginaConsole,
            stopOnSelector: ':not(*)'
        });

        divPaginaConsole.children(':not(.stdin, .stdout)').remove();
    }

    function divideDocumentoEmPaginas() {
        let novoRoot = $('<div id="novoRoot"></div>');
        $('body > *').appendTo(novoRoot);
        novoRoot.appendTo($('body'));
        
        let numPagina = 1;
        firstH2 = $('#novoRoot h2').first();
        do {
            let paginaAtual = criaPagina(numPagina);
            numPagina++;
            
            moveElementAndSiblings({
                element: firstH2,
                destinationElement: paginaAtual,
                stopOnSelector: 'h2'
            });
            firstH2 = $('#novoRoot h2').first();
        } while (firstH2.length > 0);

        novoRoot.remove();
    }
    
    function criaPagina(numPagina) {
        let paginaAtual = $('<div></div>');
        paginaAtual.addClass("pagina");
        if (numPagina == 1) {
            paginaAtual.addClass("pagina-atual");
        }
        paginaAtual.addClass("pagina" + numPagina);
        paginaAtual.appendTo($('body'));
        return paginaAtual;
    }

    function moveElementAndSiblings(params) {
        let elem = params['element'];
        let destinationElement = params['destinationElement'];
        let stopOnSelector = params['stopOnSelector'];
        
        destinationElement = $(destinationElement);
        elem = $(elem);
        if (elem.length == 0) {
            return undefined;
        }
        
        do {
            let sibling = elem.next();
            elem.appendTo(destinationElement);
            elem = sibling;
        } while (elem.length != 0 && !elem.is(stopOnSelector));

        return elem;
    }
});