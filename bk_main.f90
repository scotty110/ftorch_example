! Example for FTorch (https://github.com/Cambridge-ICCS/FTorch/blob/main/examples/1_SimpleNet/simplenet_infer_fortran.f90)
program inference

    ! Import precision info from iso
    use, intrinsic :: iso_fortran_env, only : sp => real32, dp => real64

    ! Import our library for interfacing with PyTorch
    use ftorch

    implicit none

    ! Set working precision for reals
    integer, parameter :: wp = dp
    integer :: i

    integer :: num_args, ix
    character(len=128), dimension(:), allocatable :: args

    ! Set up Fortran data structures
    integer, parameter :: x_len = 840
    integer, parameter :: l_len = 12 
    real(wp) :: in_x(x_len) 
    real(wp) :: in_l(l_len) 

    real(wp), dimension(560), target :: out_data

    integer :: tensor_layout(1) = [1]

    ! Set up Torch data structures
    ! The net, a vector of input tensors (in this case we only have one), and the output tensor
    type(torch_model) :: model
    type(torch_tensor), dimension(2) :: in_tensors
    type(torch_tensor), dimension(1) :: out_tensors

    ! Get TorchScript model file as a command line argument
    num_args = command_argument_count()
    allocate(args(num_args))
    do ix = 1, num_args
        call get_command_argument(ix, args(ix))
    end do

    ! Initialise data
    do i = 1, x_len
        in_x(i) = real(i, wp)
    end do
    
    do i = 1, l_len
        in_l(i) = real(i, wp)
    end do


    write(*,*) 'Loading model...'

    ! Load the Model
    !call torch_model_load(model, args(1), torch_kCUDA, device_index=0) 
    call torch_model_load(model, args(1), torch_kCUDA)

    write(*,*) 'Running inference...'

    ! Push data
    call torch_tensor_from_array(in_tensors(1), in_x, tensor_layout, torch_kCUDA)
    call torch_tensor_from_array(in_tensors(2), in_l, tensor_layout, torch_kCUDA)

    call torch_tensor_from_array(out_tensors(1), out_data, tensor_layout, torch_kCPU)

    ! Run the model
    !call torch_model_forward(model, in_tensors, out_tensors)

    do i =1, 100000
        !call torch_model_forward(model, in_tensors, out_tensors)
        call torch_model_forward(model, in_tensors, out_tensors)
    end do

    write(*,*) out_data(:)
    call torch_model_delete(model)
    call torch_tensor_delete(in_tensors(1))
    call torch_tensor_delete(out_tensors(1))

end program inference
