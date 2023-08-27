document.addEventListener('alpine:init', () => {
    Alpine.store('triple', {
        ready: false,
        pages: [],
        currentPage: 0,
        move(delta) {
            if (this.currentPage + delta >= 0 && this.currentPage + delta < this.pages.length) {
                this.currentPage += delta;
            }
        },
        isFirstPage() {
            return this.currentPage == 0;
        },
        isLastPage() {
            return this.currentPage == this.pages.length - 1;
        }
    });
});

$(document).ready(() => {
    if (document.triplePage) {
        const container = $('#triple-container');

        $('.postpost-content').hide();
        $('h2').each((i, elemH2) => {
            let page = $(`<div x-bind:class="{'pagina': true, 'pagina-atual': $store.triple.currentPage == ${i}}"></div>`);
            let body = $(`<div class="pagina-corpo"></div>`);
            let editor = $(`<div class="pagina-codigo"></div>`);
            let console = $(`<div class="pagina-console"></div>`);
            body.appendTo(page);
            editor.appendTo(page);
            console.appendTo(page);
            page.appendTo(container);
            
            let elem = $(elemH2);
            
            while (elem.next().length > 0 && elem.next().prop('tagName') != 'H2') {
                // jquery next sibiling of element
                const nextSibling = $(elem.next());
                
                if (elem.is('textarea.code, div.CodeMirror, button.go, .button-div')) {
                    elem.appendTo(editor);
                    // editorElems.push(elem);
                } else if (elem.is('.stdin, .stdout, .testresults')) {
                    elem.appendTo(console);
                    // consoleElems.push(elem);
                } else if (elem.is('.testcode, .testcases')) {
                    // remove
                    // elem.remove();
                } else {
                    elem.appendTo(body);
                    // bodyElems.push(elem);
                }
                
                elem = nextSibling;
            }

            Alpine.store('triple').pages.push({
                title: elemH2.innerText,
                index: i,
            });
        });

        $('.postpost-content').remove();
        Alpine.store('triple').ready = true;
    }
});