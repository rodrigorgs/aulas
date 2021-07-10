$(document).ready(() => {
    function exibeOculta(exibe, oculta) {
        $(oculta).hide();
        $(exibe)[0].style.visibility = 'visible';
    }

    function ocultaResultado(resultado) {
        $(resultado).before(function() {
            let elem = $('<button class="btn-resultado">👀</button>');
            $(elem).click(() => { exibeOculta(resultado, elem); } );
            return elem;
        });
    }

    // Oculta resultado
    $('.resultado').each(function () {
        ocultaResultado(this);
    });

    // Oculta resultado expresso em comentários
    $('.hljs-comment').each(function () {
        let elem = $(this);
        if (elem.text().trim().match(/^(\/\/|#)=>/)) {
            let newText = elem.text().replace(/(\/\/|#)=>/, '').trim();
            let newElem = $('<span class="resultado">' + newText + '</span>');
            elem.replaceWith(newElem);
            ocultaResultado(newElem);
        }
    });
});