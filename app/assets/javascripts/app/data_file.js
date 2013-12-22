$(document).ready(function () {
	
  $('#transpose_hands_grid').on('click', function() {
    selector = $("#grid");
    var data = selector.handsontable("getData");

    var transposed = transpose(data);
    var handsontable = selector.data('handsontable');
    handsontable.loadData(transposed);

    function transpose(a) {
          return Object.keys(a[0]).map(function (c) {
              return a.map(function (r) {
                  return r[c];
              });
          });
      }

      return false;

  });

  $('#search_in_hands_grid').keyup(function (event) {

    var value = ('' + this.value).toLowerCase(), row, col, r_len, c_len, td;

    if (value) {
      
      $("#grid table td").filter(function(){

        if ($(this).text().toLowerCase().indexOf(value) >-1) {
          $(this).css("background-color", "#FFFF00")
          
        }else{
          $(this).css("background-color", "")
        }
            
      });

    }else {
      $("#grid table td").css("background-color", "");
    }

  });

  $("#grid > th:first div.relative").html("he its hack")

});


// show scroller
$(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
        $("#scroll-topper").fadeIn();
    } else {
        $("#scroll-topper").fadeOut();
    }
});

function handsontable_with_filter(selector, data, readonly) {

    var columns = [];
    var spare_row = 15;
    
    for (var i = 10 - 1; i >= 0; i--) {
      columns.push([{type: 'checkbox'}])
    };

    
    if (data.length > 0) {
      spare_row = 1;
      
      columns = [];

      for (var i = data[1].length - 1; i >= 0; i--) { 
        var value = data[1][i];
        var type = "checkbox"
        
        if (typeof(value) == "number") {
          type = 'numeric'
        }

        if (typeof(value) !== "object" || value) {

          columns.push([{type: type, data: data[0][i]}]);  
        }        
        
      }
      
    }

    if (readonly) {
     spare_row = 0; 
    }

    $(selector).handsontable({
      data: data,
      colHeaders: true,
      rowHeaders: true,
      minSpareRows: spare_row,
      minSpareCols: 1,
      type: 'numeric',
      stretchH: 'all',      
      readOnly: readonly,
      manualColumnResize: true,
      manualColumnMove: true,
      persistentState: true,
      columnSorting: true,      
      fixedRowsTop: 1,
      fixedColumnsLeft: 1,
      overflow: scroll,
      autoWrapRow: true,
      contextMenu: true,
      outsideClickDeselects: false,
      cells: function (row, col, prop) {
          if (row === 0) {
            var cellProperties = {
              type: 'text' //force text type for first row
            }
            return cellProperties;
          }
        },

      afterGetColHeader: function (col, TH) {

          columns = $(selector).handsontable('getColHeader');
          var instance = this;
          var menu = buildMenu(columns[col].type);

          var $button = buildButton();
          $button.click(function (e) {

            e.preventDefault();
            e.stopImmediatePropagation();

            $('.changeTypeMenu').hide();

            menu.show();

            menu.position({
               my: 'left top',
               at: 'left bottom',
               of: $button,
               within: instance.rootElement
            });

            $(document).off('click.changeTypeMenu.hide');

            $(document).one('click.changeTypeMenu.hide', function () {
               menu.hide();
            });


          });

          menu.on('click', 'li', function () {
             setColumnType(col, $(this).data('colType'), instance);
          });

          TH.firstChild.appendChild($button[0]);
          TH.appendChild(menu[0]);
        }        
      

    });

    function firstRowRenderer(instance, td, row, col, prop, value, cellProperties) {
      Handsontable.TextCell.renderer.apply(this, arguments);
      td.style.fontWeight = 'bold';
      td.style.color = 'black';
      td.style.background = '#f0f0f0';
    }
    function buildMenu(activeCellType) {
      var menu = $('<ul></ul>').addClass('changeTypeMenu');

      $.each(['text', 'numeric', 'date', 'checkbox'], function(i, type) {
        var item = $('<li></li>').data('colType', type).text(type);

        if (activeCellType == type) {
          item.addClass('active');
        }

        menu.append(item);

      });

      return menu;

    }

    function buildButton() {
      return $('<button></button>').addClass('changeType').html('\u25BC');
    }

    function setColumnType(i, type, instance) {
      columns = $(selector).handsontable('getColHeader');
      columns[i].type = type;
      instance.updateSettings({columns: columns});
      instance.validateCells(function() {
        instance.render();
      });
    }        
    

  $("#addRow").click(function() {
    columns.push({});
    $("#grid").handsontable("render");
    return false;
  });

  $(selector+' table').addClass('table-hover table-condensed');
  $(selector+' table tbody tr:first').css("background-color", "blue").css('font-weight', 'bold');  

  function ConvertToCSV(objArray) {
    var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
    var str = '';

    for (var i = 0; i < array.length; i++) {
        var line = '';
        for (var index in array[i]) {
            if (line != '') line += ','

            line += array[i][index];
        }

        str += line + '\r\n';
    }

    return str;
  }

  console.log(ConvertToCSV(data));



}