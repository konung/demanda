<script>
  export let inputName = "number";
  export let id = "number";
  export let maxlength = 40;
  export let label = "";
  export let value = "";
  export let placeholder = "";
  export let icon = null;
  export let error = false;
  export let decimal = true;
  export let focused = false;
  export let hintMessage = "Please add a number";
</script>

<div class="form-element pb-4">
  <label class="text-gray-700" for={id}>{label}</label>
  <!-- svelte-ignore a11y-autofocus -->
  <div class="relative">
    {#if icon}
      <div
        class="absolute inset-y-0 left-0 pl-2 text-gray-600 flex items-center">
        <i class="material-icons">{icon}</i>
      </div>
    {/if}
    <input
      bind:value
      on:input={(event) => {
        const number = event.target.value;
        if (number.length > maxlength) {
          value = number.slice(0, maxlength);
        }
        error = false;
      }}
      autofocus={focused}
      on:blur
      name={inputName}
      type="number"
      step={decimal ? '0.01' : '1'}
      class="form-input mt-1 block w-full text-lg z-50 {icon ? 'pl-10' : ''}"
      class:invalidInput={error}
      {placeholder} />
  </div>
  <span class="text-sm {error ? 'hintError' : 'hint'}">{hintMessage}</span>
</div>
