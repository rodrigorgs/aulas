// Author: rodrigorgs@ufba.br

(function () {
  function initSurvey() {
    const groups = document.querySelectorAll('.survey ul');
    let groupIdx = 0;
    for (const group of groups) {
      const groupContents = group.innerHTML;
      const fieldset = document.createElement('fieldset');
      fieldset.innerHTML = groupContents;
      group.replaceWith(fieldset);
  
      const items = fieldset.querySelectorAll('li');
      let itemIdx = 0;
      for (const item of items) {
        const contents = item.innerHTML;
        const label = document.createElement('label');
        label.innerHTML = `<input type="radio" name="g${groupIdx}" value="${itemIdx}"> ${contents}<br>`;
        item.replaceWith(label);
        
        itemIdx++;
      }
      groupIdx++;
    }
  }
  
  document.addEventListener("DOMContentLoaded", function(e) {
    initSurvey();
  })
})();
