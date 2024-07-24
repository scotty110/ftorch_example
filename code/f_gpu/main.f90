program list_devices
    use, intrinsic :: iso_c_binding, only: c_int, c_char
    use ftorch
    implicit none
  
    integer :: i, num_devices, device_id
    character(len=100) :: device_name
  
    ! Initialize the FTorch library (if required)
    call ft_init()
  
    ! Get the number of available devices
    call ft_device_count(num_devices)
  
    ! Print the number of available devices
    print *, "Number of available devices: ", num_devices
  
    ! Loop through and print each device's ID and name
    do i = 0, num_devices-1
       device_id = i
       call ft_get_device_name(device_id, device_name)
       print *, "Device ID: ", device_id, ", Device Name: ", trim(device_name)
    end do
  
  end program list_devices