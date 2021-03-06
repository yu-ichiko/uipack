var _ = require('lodash');
var $ = require('jquery');
var tv4 = require('tv4');

<uipack-input>
    <div class="form-group">
        <label if={title} class="control-label" for={opts.key}>{title}</label>
        <input class="form-control" id={opts.key} type={type} placeholder={placeholder} value={value} onkeyup={validate}>
        <span if={help} class="help-block" id={'hele-' + opts.key}>{help || ''}</span>
    </div>

    <script type="text/javascript">
        var key = opts.key;
        var schema = opts.schema.properties[key];
        var input = opts.input[key];
        // console.log('[uipack-input]', key, input, schema);

        this.type = input.type;
        if (!this.type) {
            this.type = (schema.type === 'integer' || schema.type === 'number') ? 'number' : 'text';
        }

        this.title = input.title || schema.title || key || '';
        this.help = input.help || '';
        this.placeholder = input.placeholder || '';
        this.value = input.value || '';

        var customValidate = _.isFunction(input.validate) ? input.validate : function() {return true;};
        this.validate = function(e) {
            var value = e.target.value;
            if (schema.type === 'integer' || schema.type === 'number') {
                value = Number(value);
            }
            var cvalid = customValidate(value);
            var svalid = tv4.validate(value, schema);
            if (cvalid && svalid) {
                $('#' + key).parent().removeClass('has-error');
            } else {
                $('#' + key).parent().addClass('has-error');
            }
        };
    </script>
</uipack-input>
