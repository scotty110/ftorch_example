! Example for FTorch (https://github.com/Cambridge-ICCS/FTorch/blob/main/examples/1_SimpleNet/simplenet_infer_fortran.f90)
program inference

    ! Import precision info from iso
    use, intrinsic :: iso_fortran_env, only : sp => real32, dp => real64

    ! Import our library for interfacing with PyTorch
    use ftorch

    implicit none

    ! Set working precision for reals
    integer, parameter :: wp = dp
    integer :: i, j, k, l

    integer :: num_args, ix
    character(len=128), dimension(:), allocatable :: args

    ! Set up Fortran data structures
    integer, parameter :: x_dim1 = 1, x_dim2 = 70, x_dim3 = 3, x_dim4 = 4 
    integer, parameter :: l_dim1 = 1, l_dim2 = 3, l_dim3 = 4 
    real(wp), dimension(x_dim1, x_dim2, x_dim3, x_dim4) :: in_x
    real(wp), dimension(l_dim1, l_dim2, l_dim3) :: landmass

    real(wp), dimension(1, 70, 3, 4), target :: out_y

    integer :: tensor_layout_4d(4) = [4,3,2,1]
    integer :: tensor_layout_3d(3) = [3,2,1]

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

    ! Initialize data
    do i = 1, x_dim1
        do j = 1, x_dim2
            do k = 1, x_dim3
                do l = 1, x_dim4
                    in_x(i, j, k, l) = real(i + j + k + l, wp)
                end do
            end do
        end do
    end do

    do i = 1, l_dim1
        do j = 1, l_dim2
            do k = 1, l_dim3
                landmass(i, j, k) = real(i + j + k, wp)
            end do
        end do
    end do

    write(*,*) 'Loading model...'

    ! Load the Model
    call torch_model_load(model, args(1), torch_kCUDA)

    ! Push data
    call torch_tensor_from_array(in_tensors(1), in_x, tensor_layout_4d, torch_kCUDA)
    call torch_tensor_from_array(in_tensors(2), landmass, tensor_layout_3d, torch_kCUDA)

    call torch_tensor_from_array(out_tensors(1), out_y, tensor_layout_4d, torch_kCPU)

    write(*,*) 'Running inference...'
    ! Run the model
    do i = 1, 100000
        call torch_model_forward(model, in_tensors, out_tensors)
    end do

    call torch_model_delete(model)
    call torch_tensor_delete(in_tensors(1))
    call torch_tensor_delete(in_tensors(2))
    call torch_tensor_delete(out_tensors(1))

end program inference
