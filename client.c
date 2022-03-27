/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yaskour <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/03/17 17:01:40 by yaskour           #+#    #+#             */
/*   Updated: 2022/03/17 18:48:05 by yaskour          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "minitalk.h"

void	send_msg(int pid, char *str)
{
	int	i;
	int	j;

	i = 0;
	while (str[i] != '\0')
	{
		j = 0;
		while (j < 8)
		{
			if ((str[i] & 128 >> j) != 0)
				kill(pid, SIGUSR1);
			else
				kill(pid, SIGUSR2);
			usleep(800);
			j++;
		}
		i++;
	}
}

int	main(int argc, char **argv)
{
	int	pid;

	if (argc == 3)
	{
		pid = atoi(argv[1]);
		send_msg(pid, argv[2]);
	}
	else
		ft_putstr_fd("invalid arguments\n", 2);
	return (0);
}
