# Write the assembly code for the main function of the mystery program
.text

.global main
main:
  # Save registers
  pushq %rbx
  pushq %r12
  pushq %r13

  # Save argv
  movq %rsi, %rbx

  # argc must be 3: program name + two arguments
  cmpq $3, %rdi
  jne wrong_args

  # Convert argv[1] from string to long
  movq 8(%rbx), %rdi
  call atol
  movq %rax, %r12

  # Convert argv[2] from string to long
  movq 16(%rbx), %rdi
  call atol
  movq %rax, %r13

  # crunch(a, b)
  movq %r12, %rdi
  movq %r13, %rsi
  call crunch

  # Check crunch's return value
  cmpq $0, %rax
  jl print_hat
  je print_tea

  # result > 0
  leaq beer_msg(%rip), %rdi
  call puts
  jmp success

print_hat:
  leaq hat_msg(%rip), %rdi
  call puts
  jmp success

print_tea:
  leaq tea_msg(%rip), %rdi
  call puts
  jmp success

wrong_args:
  leaq error_msg(%rip), %rdi
  call puts
  movl $1, %eax

  popq %r13
  popq %r12
  popq %rbx
  ret

success:
  movl $0, %eax

  popq %r13
  popq %r12
  popq %rbx
  ret

.data
error_msg:
  .asciz "Two arguments required."
hat_msg:
  .asciz "hat"
tea_msg:
  .asciz "tea"
beer_msg:
  .asciz "beer"
