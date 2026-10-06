# Write the assembly code for the array_max function

.text

.global array_max
array_max:
  # Start with the first element as the maximum
  movq (%rsi), %rax

  # i = 1
  movq $1, %rcx

loop:
  # Stop when i >= number of elements
  cmpq %rdi, %rcx
  jae done

  # Get items[i]
  movq (%rsi,%rcx,8), %rdx

  # If items[i] <= current max, don't update
  cmpq %rax, %rdx
  jbe next

  # Otherwise update maximum
  movq %rdx, %rax

next:
  incq %rcx
  jmp loop

done:
  ret
