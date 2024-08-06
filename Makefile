MAKEFLAGS += --silent

NAME=cub3d
RAW_SRCS= $(shell find src)
SRCS = $(filter %.c, $(RAW_SRCS))
OBJS = $(SRCS:.c=.o)

LIBFT_PATH=./libs/libft/libft.a
MINILIBX_PATH=./libs/minilibx/libmlx.a

COMPILER = clang -g -Wall -Wextra -Werror -I ./headers

.c.o:
	@ $(COMPILER) -c $< -o $(<:.c=.o)

all: $(NAME)

$(NAME): $(OBJS)
	@ make -C ./libs/minilibx
	@ echo "🚀 minilibx compiled"
	@ make -C ./libs/libft
	@ $(COMPILER) $(OBJS) -o $(NAME) $(LIBFT_PATH) $(MINILIBX_PATH) -lXext -lX11 -lm #-lz
	make clean
	@ echo "✅ cube3d compile complete!\n"

clean:
	@ make -C ./libs/minilibx clean
	@ echo "🧹 minilibx clean complete!"
	@ make -C ./libs/libft clean
	@ rm -f $(OBJS)
	@ echo "🧹 cube3d clean complete!\n"

fclean:	clean
	@ make -C ./libs/libft fclean
	@rm -f $(NAME)
	@ echo "🧹 cube3d fclean complete!\n"

re: fclean all

norm:
	@ norminette src/ headers/
